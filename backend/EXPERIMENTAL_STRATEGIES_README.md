# Experimental Strategies A/B Testing

This document describes how to use the new experimental strategies functionality in IntelliCS for conducting A/B testing on different learning approaches.

## Overview

The experimental strategies system allows administrators to assign users to different learning strategies that control which interaction types trigger mastery updates. This enables researchers and teachers to test the effectiveness of different instructional approaches.

## Default Strategies

The system comes with four pre-configured strategies:

### 1. CONTROL
- **Description**: Control group - only QUESTION_ATTEMPTED interactions update mastery
- **Mastery Updates**: `QUESTION_ATTEMPTED` (weight: 1.0)
- **Use Case**: Baseline comparison group

### 2. HINT_SUPPORT
- **Description**: Hint support group - QUESTION_ATTEMPTED + HINT_REQUESTED interactions update mastery
- **Mastery Updates**: 
  - `QUESTION_ATTEMPTED` (weight: 1.0)
  - `HINT_REQUESTED` (weight: 0.5)
- **Use Case**: Testing if hint usage improves learning outcomes

### 3. SCAFFOLD_SUPPORT
- **Description**: Scaffold support group - QUESTION_ATTEMPTED + SCAFFOLD_ATTEMPTED interactions update mastery
- **Mastery Updates**: 
  - `QUESTION_ATTEMPTED` (weight: 1.0)
  - `SCAFFOLD_ATTEMPTED` (weight: 0.3)
- **Use Case**: Testing if scaffold usage improves learning outcomes

### 4. FULL_SUPPORT
- **Description**: Full support group - QUESTION_ATTEMPTED + HINT_REQUESTED + SCAFFOLD_ATTEMPTED interactions update mastery
- **Mastery Updates**: 
  - `QUESTION_ATTEMPTED` (weight: 1.0)
  - `HINT_REQUESTED` (weight: 0.5)
  - `SCAFFOLD_ATTEMPTED` (weight: 0.3)
- **Use Case**: Testing if maximum support improves learning outcomes

## API Endpoints

### Strategy Management

#### Get All Active Strategies
```http
GET /api/admin/experimental-strategies
Authorization: Bearer {admin_token}
```

#### Get Strategy by ID
```http
GET /api/admin/experimental-strategies/{strategyId}
Authorization: Bearer {admin_token}
```

#### Get Strategy with Rules
```http
GET /api/admin/experimental-strategies/{strategyId}/with-rules
Authorization: Bearer {admin_token}
```

#### Create New Strategy
```http
POST /api/admin/experimental-strategies
Authorization: Bearer {admin_token}
Content-Type: application/json

{
  "strategyName": "CUSTOM_STRATEGY",
  "description": "Custom strategy for specific research needs"
}
```

#### Update Strategy
```http
PUT /api/admin/experimental-strategies/{strategyId}
Authorization: Bearer {admin_token}
Content-Type: application/json

{
  "strategyName": "UPDATED_STRATEGY",
  "description": "Updated description",
  "isActive": true
}
```

#### Deactivate Strategy
```http
DELETE /api/admin/experimental-strategies/{strategyId}
Authorization: Bearer {admin_token}
```

### User Assignment Management

#### Assign User to Strategy
```http
POST /api/admin/experimental-strategies/{strategyId}/assign-user/{userId}?assignedBy={adminUserId}
Authorization: Bearer {admin_token}
```

#### Change User's Strategy
```http
PUT /api/admin/experimental-strategies/users/{userId}/change-strategy/{newStrategyId}?assignedBy={adminUserId}
Authorization: Bearer {admin_token}
```

#### Get User's Current Strategy
```http
GET /api/admin/experimental-strategies/users/{userId}/assignment
Authorization: Bearer {admin_token}
```

#### Remove User's Strategy Assignment
```http
DELETE /api/admin/experimental-strategies/users/{userId}/assignment
Authorization: Bearer {admin_token}
```

#### Get All Users in a Strategy
```http
GET /api/admin/experimental-strategies/{strategyId}/users
Authorization: Bearer {admin_token}
```

#### Get User Count in Strategy
```http
GET /api/admin/experimental-strategies/{strategyId}/user-count
Authorization: Bearer {admin_token}
```

## Usage Examples

### 1. Assign a User to HINT_SUPPORT Strategy

```bash
curl -X POST \
  "http://localhost:8080/api/admin/experimental-strategies/{strategyId}/assign-user/{userId}" \
  -H "Authorization: Bearer {admin_token}" \
  -H "Content-Type: application/json"
```

### 2. Check User's Current Strategy

```bash
curl -X GET \
  "http://localhost:8080/api/admin/experimental-strategies/users/{userId}/assignment" \
  -H "Authorization: Bearer {admin_token}"
```

### 3. Get All Users in CONTROL Strategy

```bash
curl -X GET \
  "http://localhost:8080/api/admin/experimental-strategies/{strategyId}/users" \
  -H "Authorization: Bearer {admin_token}"
```

## How It Works

### 1. Strategy Assignment
- Users are automatically assigned to the CONTROL strategy when they first interact with the system
- Admins can manually assign users to different strategies
- Users can only be assigned to one strategy at a time

### 2. Mastery Update Logic
- When a user interaction occurs, the system checks the user's assigned strategy
- Only interaction types marked as "required" in the strategy trigger mastery updates
- The mastery update weight from the strategy rule is used instead of the default weight

### 3. Data Collection
- All interactions are logged regardless of strategy
- Strategy information is linked to users, not individual interactions
- This enables clean A/B testing analysis

## Research Applications

### 1. Learning Support Effectiveness
- Compare CONTROL vs HINT_SUPPORT to see if hints improve learning
- Compare CONTROL vs SCAFFOLD_SUPPORT to see if scaffolds improve learning
- Compare CONTROL vs FULL_SUPPORT to see if maximum support improves learning

### 2. Adaptive Learning Research
- Test different mastery update weights for the same interaction types
- Create custom strategies for specific research questions
- Conduct longitudinal studies on strategy effectiveness

### 3. Educational Psychology
- Study how different levels of support affect student engagement
- Analyze learning patterns across different support levels
- Measure the impact of scaffolding on knowledge retention

## Database Schema

The system adds three new tables:

- `experimental_strategies`: Stores strategy definitions
- `strategy_interaction_rules`: Defines which interaction types trigger mastery updates for each strategy
- `user_experimental_assignments`: Links users to their assigned strategies

## Monitoring and Analysis

### 1. Strategy Performance Metrics
- User engagement levels per strategy
- Learning outcome comparisons across strategies
- Time-to-mastery analysis per strategy

### 2. Statistical Analysis
- A/B testing significance testing
- Effect size calculations
- Longitudinal trend analysis

### 3. Research Reporting
- Strategy effectiveness reports
- Learning outcome comparisons
- Student engagement analysis

## Best Practices

### 1. Strategy Design
- Keep strategies simple and focused
- Use meaningful strategy names
- Document the rationale for each strategy

### 2. User Assignment
- Ensure balanced assignment across strategies
- Monitor assignment distribution
- Avoid frequent strategy changes for the same user

### 3. Data Analysis
- Collect sufficient data before analysis
- Use appropriate statistical tests
- Consider confounding variables

## Troubleshooting

### Common Issues

1. **User Not Assigned to Strategy**
   - Check if user exists in `user_experimental_assignments`
   - Use `/ensure-assignment` endpoint to create default assignment

2. **Strategy Not Found**
   - Verify strategy exists and is active
   - Check strategy ID in API calls

3. **Mastery Updates Not Working**
   - Verify user has strategy assignment
   - Check strategy interaction rules
   - Review system logs for errors

### Debug Endpoints

- `/api/admin/experimental-strategies/users/{userId}/assignment` - Check user's strategy
- `/api/admin/experimental-strategies/{strategyId}/with-rules` - View strategy rules
- `/api/admin/experimental-strategies/{strategyId}/users` - List users in strategy

## Future Enhancements

- Group-based strategy assignments
- Dynamic strategy switching based on performance
- Advanced statistical analysis tools
- Integration with external research platforms
- Automated strategy recommendation engine
