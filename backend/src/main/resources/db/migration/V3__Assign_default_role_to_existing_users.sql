-- Ensure ROLE_USER exists
INSERT INTO roles (role_id, name)
SELECT gen_random_uuid(), 'ROLE_USER'
WHERE NOT EXISTS (SELECT 1 FROM roles WHERE name = 'ROLE_USER');

-- Assign ROLE_USER to all users who do not have any roles
INSERT INTO user_roles (user_id, role_id)
SELECT u.user_id, r.role_id
FROM users u
JOIN roles r ON r.name = 'ROLE_USER'
WHERE NOT EXISTS (
    SELECT 1 FROM user_roles ur WHERE ur.user_id = u.user_id
);

