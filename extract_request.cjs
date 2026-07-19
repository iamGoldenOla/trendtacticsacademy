const fs = require('fs');
const path = require('path');

const transcriptPath = path.join(
  'C:\\Users\\Akinola Olujobi\\.gemini\\antigravity\\brain\\24a26cdb-ac7d-4c1d-bf20-857400faa4e8\\.system_generated\\logs',
  'transcript_full.jsonl'
);

function main() {
  if (!fs.existsSync(transcriptPath)) {
    console.error('File not found:', transcriptPath);
    return;
  }
  
  const content = fs.readFileSync(transcriptPath, 'utf8');
  const lines = content.split('\n').filter(Boolean);
  
  let latestUserMessage = null;
  // Iterate backwards to find the last USER_INPUT step
  for (let i = lines.length - 1; i >= 0; i--) {
    try {
      const step = JSON.parse(lines[i]);
      if (step.type === 'USER_INPUT') {
        latestUserMessage = step;
        break;
      }
    } catch (e) {
      // ignore parse errors
    }
  }
  
  if (!latestUserMessage) {
    console.log('No user input step found.');
    return;
  }
  
  console.log('=== LATEST USER MESSAGE FOUND ===');
  const msgContent = latestUserMessage.content || '';
  console.log('Length:', msgContent.length);
  
  // Save to file for easy reading
  const outPath = 'C:\\Users\\Akinola Olujobi\\Documents\\Trendtactics Academy\\extracted_user_request.txt';
  fs.writeFileSync(outPath, msgContent, 'utf8');
  console.log('Successfully wrote untruncated message to:', outPath);
}

main();
