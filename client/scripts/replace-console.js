#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const glob = require('glob');

// Function to replace console statements with logger
function replaceConsoleStatements(content) {
  return content
    .replace(/console\.log\(/g, 'logger.log(')
    .replace(/console\.error\(/g, 'logger.error(')
    .replace(/console\.warn\(/g, 'logger.warn(')
    .replace(/console\.info\(/g, 'logger.info(')
    .replace(/console\.debug\(/g, 'logger.debug(');
}

// Function to add logger import if not present
function addLoggerImport(content) {
  if (content.includes('logger') || content.includes('from \'@/lib/utils\'')) {
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
  
  return content;
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
      '**/*.bundle.js'
    ]
  });
  
  let processedCount = 0;
  
  files.forEach(file => {
    try {
      const content = fs.readFileSync(file, 'utf8');
      
      // Check if file contains console statements and is a source file
      if (content.includes('console.') && !file.includes('out/') && !file.includes('.next/')) {
        let newContent = replaceConsoleStatements(content);
        newContent = addLoggerImport(newContent);
        
        if (newContent !== content) {
          fs.writeFileSync(file, newContent, 'utf8');
          console.log(`✅ Updated: ${file}`);
          processedCount++;
        }
      }
    } catch (error) {
      console.error(`❌ Error processing ${file}:`, error.message);
    }
  });
  
  console.log(`\n🎉 Processed ${processedCount} files!`);
  console.log('Now you can control all logging with the logger utility.');
}

// Run the script
if (require.main === module) {
  processFiles();
}

module.exports = { replaceConsoleStatements, addLoggerImport };
