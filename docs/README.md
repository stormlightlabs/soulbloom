# Flutter Wellness App Development Plan

Architect Flutter app with potential Swift migration in mind - keep
platform-specific code well-organized and modular

Use Flutter's platform channels from the start for any iOS-specific functionality

## Main Loop Structure

Player enters their space (garden/grove)

Daily draw mechanics:

Option to draw from different themed decks (e.g., "Mindfulness Grove", "Self-Care Spring", "Emotional Garden")
Each deck represents different types of activities/exercises
Random but weighted selection based on player's needs/progress

Activity engagement:

Card reveals the activity
Player can choose to:

Accept and do the activity now
Save for later
Draw a different card (with limited redraws per day)

Completion and rewards:

Mark activity as complete
Receive magical essence/seeds/growth points
See their garden grow or change

Progress tracking:

Cards played get added to a "wisdom journal"
Garden/space evolves based on types of activities completed
New card decks unlock as player progresses

Key Design Considerations:

Keep daily sessions short (5-15 minutes)
Allow flexibility in engagement
Balance randomness with intentional progression
Include "quick draw" option for busy days
Save completed activities locally first, sync when possible

### Card Deck Categories

Card Deck Categories:

Journal Garden

Reflective prompts
Gratitude exercises
Mood tracking
Future self letters
Memory garden entries

ACT Grove (Acceptance & Commitment)

Values clarification exercises
Present moment awareness
Defusion techniques
Self-as-context activities
Committed action steps

DBT Meadow (Dialectical Behavior)

Mindfulness practices
Distress tolerance
Emotion regulation
Interpersonal effectiveness
Chain analysis exercises

CBT Forest (Cognitive Behavioral)

Thought records
Behavioral activation
Core belief work
Cognitive restructuring
Pattern recognition

Movement/Adventure Cards

Walking meditations
"Gather magical herbs" (timed walks)
"Forest dance" (movement exercises)
"River flow" (stretching)
Outdoor mindfulness quests
"Magical creature spotting" (nature observation walks)

Spellcraft Grove (Creativity):

Creative Expression Cards

"Potion brewing" (creative writing)
"Spell weaving" (art/drawing prompts)
"Enchanted melodies" (music/sound activities)
"Dream crystals" (visualization exercises)
"Stardust stories" (narrative therapy)
"Color magic" (expressive arts)

Game Flow Integration:

Daily draws could pull from multiple decks to create a balanced "hand"
Players unlock deeper/more advanced cards as they master basics
Journal entries could influence which cards appear more frequently
Completed activities feed into the garden's growth and evolution
Visual metaphors match each framework (e.g., untangling vines for cognitive restructuring)
Movement cards could unlock special garden areas or magical ingredients
Creative activities could manifest as unique magical plants or artifacts in the garden
Combine cards for interesting effects (e.g., "Walk while crafting a story")
Adventure rewards feed into other activities (finding materials for creative projects)
Creativity exercises could personalize the player's garden space
