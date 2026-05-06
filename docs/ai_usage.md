# AI Usage Notes

## How AI Was Used

AI tools were used to accelerate:

- feature breakdown
- TDD planning
- test case brainstorming
- service object structure
- frontend layout ideas
- edge case discovery
- README and documentation drafting

## How Quality Was Maintained

AI-generated suggestions were manually reviewed before implementation.

The final decisions were based on:

- assignment requirements
- Rails best practices
- clean architecture
- production-readiness
- test coverage
- performance considerations

## Important Human Decisions

The following decisions were intentionally reviewed and corrected:

- salary must be greater than 0, not greater than or equal to 0
- salary insights by job title require both country and job title
- query params should be normalized before analytics
- frontend should avoid API calls while users are typing
- seed script should use bulk insertion for performance

## TDD Workflow

Major backend features followed:

1. Red - failing spec
2. Green - minimal implementation
3. Refactor - improve structure

This helped keep the implementation safe and easy to review.