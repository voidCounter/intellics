package org.intellics.backend;

import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.utility.DockerImageName;

public class TestContainerManager {
    private static PostgreSQLContainer<?> postgres;
    private static boolean initialized = false;

    public static synchronized PostgreSQLContainer<?> getInstance() {
        if (postgres == null) {
            postgres = new PostgreSQLContainer<>(DockerImageName.parse("postgres:16-alpine"))
                    .withDatabaseName("testdb")
                    .withUsername("testuser")
                    .withPassword("testpass");
            postgres.start();
            initialized = true;
        }
        return postgres;
    }

    public static synchronized void stop() {
        if (postgres != null && postgres.isRunning()) {
            postgres.stop();
            postgres = null;
            initialized = false;
        }
    }

    public static boolean isInitialized() {
        return initialized;
    }
}
