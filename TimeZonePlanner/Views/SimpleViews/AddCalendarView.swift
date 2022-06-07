//
//  AddCalendarView.swift
//  TimeZonePlanner
//
//  Created by Sergei Kriukov on 05.06.2022.
//
import SwiftUI
import EventKitUI
struct AddCalendarView: UIViewControllerRepresentable {
    @EnvironmentObject var model:TimeModel
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    @Environment(\.presentationMode) var presentationMode
    
   // let eventStore: EKEventStore
    let eventStore = EKEventStore()

    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<AddCalendarView>) -> EKEventEditViewController {
        
        let eventEditViewController = EKEventEditViewController()
        eventEditViewController.eventStore = eventStore
        

        let event = EKEvent.init(eventStore: eventStore)
        var endDate = model.date
        endDate = model.date.addingTimeInterval(3600)
        event.endDate = endDate
        event.startDate = model.date
        eventEditViewController.event = event
        eventEditViewController.editViewDelegate = context.coordinator
        
        return eventEditViewController
    }
    
   func updateUIViewController(_ uiViewController: EKEventEditViewController, context: UIViewControllerRepresentableContext<AddCalendarView>) {
        
    }
    
    class Coordinator: NSObject, EKEventEditViewDelegate {
        let parent: AddCalendarView
        
        init(_ parent: AddCalendarView) {
            self.parent = parent
        }
        
        func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
            parent.presentationMode.wrappedValue.dismiss()
            
            if action != .canceled {
                NotificationCenter.default.post(name: .eventsDidChange, object: nil)
            }
        }
    }

}

