package com.upgread.upgread.model.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Challenge {
    int challengeId;
    String challengeName;
    String description;
    int duration;
    Type type;
    int goal;
    int participantCount;
    String participationStatus;
}
