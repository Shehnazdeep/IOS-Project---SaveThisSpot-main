//
//  WidgetSaveThisSpot.swift
//  WidgetSaveThisSpot
//
// Group 8
// Zubear Nassimi id# 991 628 529
// Shehnazdeep Kaur id# 991 539 256
//

import WidgetKit
import SwiftUI
import Intents

struct SimpleEntry: TimelineEntry {
    let date: Date
    let locationLabel: String
    let locationDescription: String
}

struct WidgetEntryView: View {
    var entry: SimpleEntry

    var body: some View {
        VStack {
            Text(entry.locationLabel)
                .font(.headline)
            Text(entry.locationDescription)
                .font(.subheadline)
        }
        .padding()
    }
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), locationLabel: "Loading...", locationDescription: "")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date(), locationLabel: "Snapshot", locationDescription: "Description")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        let sharedDefaults = UserDefaults(suiteName: "group.UserDefaultsSavedLocation")
        let label = sharedDefaults?.string(forKey: "lastLocationLabel") ?? "Unknown Location"
        let description = sharedDefaults?.string(forKey: "lastLocationDescription") ?? "No Description"

        let entry = SimpleEntry(date: Date(), locationLabel: label, locationDescription: description)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct WidgetSaveThisSpot: Widget {
    private let kind: String = "WidgetSaveThisSpot"

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Last Saved Location")
        .description("Shows the last location saved in the app.")
    }
}
