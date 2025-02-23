//
//  UserDataModel.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 23/2/25.
//
import SwiftData
import SwiftUI

@Model
class UserDataModel {
    @Attribute(.unique) var id: String
    var name: String
    var photo: Data?
    var activityGroups: [ActivityGroupModel]

    init(id: String, name: String, photo: Data? = nil, activityGroups: [ActivityGroupModel] = []) {
        self.id = id
        self.name = name
        self.photo = photo
        self.activityGroups = activityGroups
    }
}

@Model
class ActivityGroupModel {
    @Attribute(.unique) var id: UUID
    var date: Date
    var activities: [ActivityModel]
    var completedActivities: Int

    init(id: UUID = UUID(), date: Date, activities: [ActivityModel], completedActivities: Int = 0) {
        self.id = id
        self.date = date
        self.activities = activities
        self.completedActivities = completedActivities
    }
}

extension ActivityGroupModel {
    var progress: Int {
        return (completedActivities * 25)
    }
    var isComplete: Bool {
        return completedActivities == 4
    }
    var color: Color {
        return isComplete ? .green : .blue
    }
}
