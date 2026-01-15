// api/chat.js - Vercel Serverless Function

export default async function handler(req, res) {
  // Enable CORS
  res.setHeader('Access-Control-Allow-Credentials', true);
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET,OPTIONS,PATCH,DELETE,POST,PUT');
  res.setHeader(
    'Access-Control-Allow-Headers',
    'X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Content-Length, Content-MD5, Content-Type, Date, X-Api-Version'
  );

  // Handle preflight
  if (req.method === 'OPTIONS') {
    res.status(200).end();
    return;
  }

  // Only allow POST
  if (req.method !== 'POST') {
    return res.status(405).json({ 
      error: 'Method not allowed',
      success: false 
    });
  }

  try {
    // Check if API key exists
    if (!process.env.OPENROUTER_API_KEY) {
      console.error('OPENROUTER_API_KEY environment variable is not set');
      return res.status(500).json({ 
        error: 'API key not configured. Please set OPENROUTER_API_KEY in Vercel environment variables.',
        success: false 
      });
    }

    const { messages } = req.body;

    if (!messages || !Array.isArray(messages)) {
      return res.status(400).json({ 
        error: 'Invalid request: messages array required',
        success: false 
      });
    }

    console.log('Calling OpenRouter API...');

    // Call OpenRouter API
    const response = await fetch('https://openrouter.ai/api/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${process.env.OPENROUTER_API_KEY}`,
        'HTTP-Referer': req.headers.referer || 'https://fedora-fixes.vercel.app',
        'X-Title': 'Fedora Fixes AI Assistant'
      },
      body: JSON.stringify({
        model: 'google/gemini-2.0-flash-exp:free',
        messages: messages,
        temperature: 0.7,
        max_tokens: 1500
      })
    });

    const responseText = await response.text();
    console.log('OpenRouter response status:', response.status);

    if (!response.ok) {
      console.error('OpenRouter API error:', responseText);
      return res.status(response.status).json({ 
        error: `OpenRouter API error: ${response.status} - ${responseText}`,
        success: false 
      });
    }

    const data = JSON.parse(responseText);
    const aiMessage = data.choices?.[0]?.message?.content || 'Sorry, I could not generate a response.';

    console.log('AI response generated successfully');

    return res.status(200).json({ 
      message: aiMessage,
      success: true 
    });

  } catch (error) {
    console.error('Server error:', error);
    return res.status(500).json({ 
      error: `Server error: ${error.message}`,
      success: false,
      details: error.stack
    });
  }
}
