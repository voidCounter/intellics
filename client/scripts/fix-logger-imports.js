#!/usr/bin/env node

const fs = require('fs');
const glob = require('glob');

// Function to add logger import if not present
function addLoggerImport(content) {
  // Check if logger is already imported
  if (content.includes('import { logger }') || content.includes('from \'@/lib/utils\'')) {
    return content;
  }
  
  // Find the last import statement and add logger import after it
  const importRegex = /import.*from.*['"][^'"]*['"];?\s*\n/g;
  const matches = content.match(importRegex);
  
  if (matches) {
    const lastImport = matches[matches.length - 1];
    const loggerImport = 'import { logger } from \'@/lib/utils\';\n';
    return content.replace(lastImport, lastImport + loggerImport);
  }
  
  // If no imports found, add at the top after 'use client' or similar
  if (content.includes("'use client'")) {
    return content.replace("'use client';", "'use client';\n\nimport { logger } from '@/lib/utils';");
  }
  
  // Add at the very beginning if no other imports
  return "import { logger } from '@/lib/utils';\n\n" + content;
}

// Main function to process files
function processFiles() {
  const files = glob.sync('**/*.{ts,tsx,js,jsx}', {
    ignore: [
      'node_modules/**', 
      'dist/**', 
      'build/**', 
      'out/**',
      '.next/**',
      'scripts/**', 
      '**/*.d.ts',
      '**/*.min.js',
      '**/*.bundle.js',
      '**/utils/logger.ts', // Don't process the logger file itself
      '**/utils.ts' // Don't process the main utils file
    ]
  });
  
  let processedCount = 0;
  
  files.forEach(file => {
    try {
      const content = fs.readFileSync(file, 'utf8');
      
      // Check if file uses logger but doesn't have the import
      if (content.includes('logger.') && !content.includes('import { logger }')) {
        const newContent = addLoggerImport(content);
        
        if (newContent !== content) {
          fs.writeFileSync(file, newContent, 'utf8');
          console.log(`✅ Added logger import to: ${file}`);
          processedCount++;
        }
      }
    } catch (error) {
      console.error(`❌ Error processing ${file}:`, error.message);
    }
  });
  
  console.log(`\n🎉 Fixed ${processedCount} files with missing logger imports!`);
}

// Run the script
if (require.main === module) {
  processFiles();
}

module.exports = { addLoggerImport };
