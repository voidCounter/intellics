package org.intellics.backend.specifications;

import org.intellics.backend.domain.entities.Session;
import org.springframework.data.jpa.domain.Specification;

import java.time.Instant;
import java.util.UUID;

public class SessionSpecification {

    public static Specification<Session> hasUserId(UUID userId) {
        return (root, query, criteriaBuilder) -> {
            if (userId == null) {
                return criteriaBuilder.conjunction();
            }
            return criteriaBuilder.equal(root.get("user").get("user_id"), userId);
        };
    }

    public static Specification<Session> hasDeviceType(String deviceType) {
        return (root, query, criteriaBuilder) -> {
            if (deviceType == null) {
                return criteriaBuilder.conjunction();
            }
            return criteriaBuilder.equal(root.get("device_type"), deviceType);
        };
    }

    public static Specification<Session> startTimeAfter(Instant startTimeAfter) {
        return (root, query, criteriaBuilder) -> {
            if (startTimeAfter == null) {
                return criteriaBuilder.conjunction();
            }
            return criteriaBuilder.greaterThanOrEqualTo(root.get("start_time"), startTimeAfter);
        };
    }

    public static Specification<Session> startTimeBefore(Instant startTimeBefore) {
        return (root, query, criteriaBuilder) -> {
            if (startTimeBefore == null) {
                return criteriaBuilder.conjunction();
            }
            return criteriaBuilder.lessThanOrEqualTo(root.get("start_time"), startTimeBefore);
        };
    }

    public static Specification<Session> endTimeAfter(Instant endTimeAfter) {
        return (root, query, criteriaBuilder) -> {
            if (endTimeAfter == null) {
                return criteriaBuilder.conjunction();
            }
            return criteriaBuilder.greaterThanOrEqualTo(root.get("end_time"), endTimeAfter);
        };
    }

    public static Specification<Session> endTimeBefore(Instant endTimeBefore) {
        return (root, query, criteriaBuilder) -> {
            if (endTimeBefore == null) {
                return criteriaBuilder.conjunction();
            }
            return criteriaBuilder.lessThanOrEqualTo(root.get("end_time"), endTimeBefore);
        };
    }

    public static Specification<Session> isActive(Boolean isActive) {
        return (root, query, criteriaBuilder) -> {
            if (isActive == null) {
                return criteriaBuilder.conjunction();
            }
            if (isActive) {
                return criteriaBuilder.isNull(root.get("end_time"));
            } else {
                return criteriaBuilder.isNotNull(root.get("end_time"));
            }
        };
    }
}
