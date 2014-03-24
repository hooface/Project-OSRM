@routing @car @surface
Feature: Car - Surfaces

    Background:
        Given the profile "car"

    Scenario: Car - Routeability of tracktype tags
        Then routability should be
            | tracktype | bothw |
            | grade1    | x     |
            | grade2    | x     |
            | grade3    | x     |
            | grade4    | x     |
            | grade5    | x     |
            | nonsense  | x     |

    Scenario: Car - Routability of smoothness tags
        Then routability should be
            | smoothness    | bothw |
            | excellent     | x     |
            | good          | x     |
            | intermediate  | x     |
            | bad           | x     |
            | very_bad      | x     |
            | horrible      | x     |
            | very_horrible | x     |
            | impassable    |       |
            | nonsense      | x     |

    Scenario: Car - Routabiliy of surface tags
        Then routability should be
            | surface  | bothw |
            | asphalt  | x     |
            | sett     | x     |
            | gravel   | x     |
            | nonsense | x     |


    Scenario: Car - Good surfaces should not grant access
        Then routability should be
            | access       | tracktype | smoothness | surface | bothw |
            |              |           |            |         | x     |
            | no           | grade1    | excellent  | asphalt |       |
            | private      | grade1    | excellent  | asphalt |       |
            | agricultural | grade1    | excellent  | asphalt |       |
            | forestry     | grade1    | excellent  | asphalt |       |
            | emergency    | grade1    | excellent  | asphalt |       |

        Scenario: Car - Impassable surfaces should deny access
        These cases are somewhat comflicting, like
        Then routability should be
            | access | smoothness | bothw |
            | yes    |            | x     |
            | yes    | impassable |       |

    Scenario: Car - Surfaces should not affect oneway direction
        Then routability should be
            | oneway | tracktype | smoothness | surface  | forw | backw |
            |        | grade1    | excellent  | asphalt  | x    | x     |
            |        | grade5    | very_bad   | mud      | x    | x     |
            |        | nonsense  | nonsense   | nonsense | x    | x     |
            | no     | grade1    | excellent  | asphalt  | x    | x     |
            | no     | grade5    | very_bad   | mud      | x    | x     |
            | no     | nonsense  | nonsense   | nonsense | x    | x     |
            | yes    | grade1    | excellent  | asphalt  | x    |       |
            | yes    | grade5    | very_bad   | mud      | x    |       |
            | yes    | nonsense  | nonsense   | nonsense | x    |       |
            | -1     | grade1    | excellent  | asphalt  |      | x     |
            | -1     | grade5    | very_bad   | mud      |      | x     |
            | -1     | nonsense  | nonsense   | nonsense |      | x     |

    @todo
    Scenario: Car - Tracktypes should reduce speed
        Then routability should be
            | highway     | tracktype | => | speed   | 
            | motorway    |           |    | 90 km/h |
            | motorway    | grade1    |    | 60 km/h |
            | motorway    | grade2    |    | 40 km/h |
            | motorway    | grade3    |    | 30 km/h |
            | motorway    | grade4    |    | 25 km/h |
            | motorway    | grade5    |    | 20 km/h |
            | tertiary    |           |    | 60 km/h |
            | tertiary    | grade1    |    | 60 km/h |
            | tertiary    | grade2    |    | 40 km/h |
            | tertiary    | grade3    |    | 30 km/h |
            | tertiary    | grade4    |    | 25 km/h |
            | tertiary    | grade5    |    | 20 km/h |
            | residential |           |    | 25 km/h |
            | residential | grade1    |    | 25 km/h |
            | residential | grade2    |    | 25 km/h |
            | residential | grade3    |    | 25 km/h |
            | residential | grade4    |    | 25 km/h |
            | residential | grade5    |    | 20 km/h |

    @todo
    Scenario: Car - Combination of surface tags should use lowest speed
        Then routability should be
            | highway     | tracktype | surface | smoothness | => | speed   | 
            | motorway    |           |         |            |    | 90 km/h |
            | service     | grade1    | asphalt | excellent  |    | 15 km/h |
            | motorway    | grade5    | asphalt | excellent  |    | 20 km/h |
            | motorway    | grade1    | mud     | excellent  |    | 10 km/h |
            | motorway    | grade1    | asphalt | horrible   |    | 10 km/h |