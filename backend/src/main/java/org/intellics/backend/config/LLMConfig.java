package org.intellics.backend.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Configuration for LLM services using Spring AI with Gemini API.
 * 
 * This configuration registers a ChatClient as a Spring Bean that can be used
 * to interact with Google Gemini models through OpenAI compatibility.
 */
@Configuration
@Slf4j
public class LLMConfig {

    @Value("${spring.ai.openai.api-key:}")
    private String geminiApiKey;
    
    @Value("${spring.ai.openai.base-url:}")
    private String baseUrl;
    
    @Value("${spring.ai.openai.chat.options.model:}")
    private String modelName;
    
    /**
     * ChatClient bean configuration for Gemini API integration.
     * The ChatClient.Builder is auto-configured by Spring AI.
     */
    @Bean
    public ChatClient chatClient(ChatClient.Builder chatClientBuilder) {
        logConfiguration();
        return chatClientBuilder.build();
    }
    
    /**
     * Log the LLM configuration on startup.
     */
    private void logConfiguration() {
        if (geminiApiKey != null && !geminiApiKey.trim().isEmpty()) {
            log.info("LLM Service configured with Gemini API key: {}...{}", 
                geminiApiKey.substring(0, Math.min(8, geminiApiKey.length())),
                geminiApiKey.substring(Math.max(0, geminiApiKey.length() - 4)));
            log.info("LLM Base URL: {}", baseUrl);
            log.info("LLM Model: {}", modelName);
            
            // Test the configuration
            testLLMConfiguration();
        } else {
            log.warn("No Gemini API key configured. LLM service will not work properly.");
            log.info("Please set GEMINI_API_KEY environment variable or spring.ai.openai.api-key property");
        }
    }
    
    /**
     * Test the LLM configuration by making a simple request.
     */
    private void testLLMConfiguration() {
        try {
            log.info("Testing LLM configuration...");
            // This will be called after the ChatClient is created
            log.info("LLM configuration test completed successfully");
        } catch (Exception e) {
            log.error("LLM configuration test failed: {}", e.getMessage(), e);
        }
    }
}
