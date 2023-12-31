package com.dollyanddot.kingmaker.domain.member.dto.response;

import lombok.Builder;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
@Builder
public class RewardListResDto {
    private String rewardNm;
    private String rewardCond;
    private String rewardMsg;
    private LocalDateTime modifiedAt;
    private boolean isAchieved;
    private int rewardPercent;
    private int rewardId;
}
