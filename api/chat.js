// api/chat.js - With user context and chat history support

export default async function handler(req, res) {
  res.setHeader('Access-Control-Allow-Credentials', true);
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET,OPTIONS,PATCH,DELETE,POST,PUT');
  res.setHeader(
    'Access-Control-Allow-Headers',
    'X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Content-Length, Content-MD5, Content-Type, Date, X-Api-Version'
  );

  if (req.method === 'OPTIONS') {
    res.status(200).end();
    return;
  }

  if (req.method !== 'POST') {
    return res.status(405).json({ 
      error: 'Method not allowed',
      success: false 
    });
  }

  try {
    if (!process.env.OPENROUTER_API_KEY) {
      console.error('OPENROUTER_API_KEY not set');
      return res.status(500).json({ 
        error: 'API key not configured',
        success: false 
      });
    }

    const { messages, model, userId, userEmail } = req.body;

    if (!messages || !Array.isArray(messages)) {
      return res.status(400).json({ 
        error: 'Invalid request: messages array required',
        success: false 
      });
    }

    // Log user interaction
    console.log(`AI Chat Request from: ${userEmail || 'anonymous'} (${userId || 'no-id'})`);
    console.log(`Message count: ${messages.length}`);

    // Use provided model or default
    const selectedModel = model || 'meta-llama/llama-3.2-3b-instruct:free';

    console.log(`Using model: ${selectedModel}`);

    const response = await fetch('https://openrouter.ai/api/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${process.env.OPENROUTER_API_KEY}`,
        'HTTP-Referer': req.headers.referer || 'https://fedora-fixes.vercel.app',
        'X-Title': 'Fedora Fixes AI Assistant'
      },
      body: JSON.stringify({
        model: selectedModel,
        messages: messages,
        temperature: 0.7,
        max_tokens: 1500
      })
    });

    const responseText = await response.text();

    if (!response.ok) {
      console.error(`Model ${selectedModel} failed:`, responseText);
      return res.status(response.status).json({ 
        error: `OpenRouter API error: ${response.status} - ${responseText}`,
        success: false 
      });
    }

    const data = JSON.parse(responseText);
    const aiMessage = data.choices?.[0]?.message?.content || 'Sorry, I could not generate a response.';

    console.log(`Success! Response length: ${aiMessage.length} chars`);

    return res.status(200).json({ 
      message: aiMessage,
      success: true,
      model: selectedModel
    });

  } catch (error) {
    console.error('Server error:', error);
    return res.status(500).json({ 
      error: `Server error: ${error.message}`,
      success: false
    });
  }
}
