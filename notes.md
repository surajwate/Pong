# Notes of Game Development

## Lecture's Scope

- [x] Draw shapes to the screen (paddles and ball)
- [x] Control 2D position of paddles based on input
- [x] Collision detection between paddles and ball to deflect ball back toward opponent
- [x] Collision detection between ball and map boundaries to keep ball within vertical bounds and to detect score (outside horizontal bounds)
- [ ] Sound effects when ball hits paddles/walls or when a point is scored for flavor
- [ ] Scorekeeping to determine winner

## AABB Collision Detection

Relies on all colliding entities to have "alix-aligned bounding boxes", which simply means their collision boxes contain no rotation in our world space, which allows us to use a simple math formula to test for collision:

if rect1.x is not > rect2.x + rect2.width and
    rect1.x + rect1.width is not < rect2.x and
    rect1.y is not > rect2.y + rect2.height and
    rect1.y + rect1.height is not < rect2.y:
        collision is true
else
        collision is false

## State Machine

