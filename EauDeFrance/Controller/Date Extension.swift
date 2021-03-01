//
//  Date Extension.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 22/02/2021.
//

import Foundation

extension Date {

    func dayOfTheWeek() -> String {
        let weekdays = [
            "Dimanche",
            "Lundi",
            "Mardi",
            "Mercredi",
            "Jeudi",
            "Vendredi",
            "Samedi"
        ]

        guard let weekday = self.posInWeek() else { return "" }
        return weekdays[weekday - 1]
    }
    func monthString() -> String {
        let month = [
            "Janvier",
            "Février",
            "Mars",
            "Avril",
            "Mai",
            "Juin",
            "Juillet",
            "Août",
            "Septembre",
            "Octobre",
            "Novembre",
            "Decembre"
        ]

        guard let calendar = NSCalendar(calendarIdentifier: .gregorian) else { return "" }
        let monthValue = calendar.component(.month, from: self)
        return month[monthValue-1]
    }

    func posInWeek() -> Int? {
        guard let calendar = NSCalendar(calendarIdentifier: .gregorian) else { return nil }
        let weekday = calendar.component(.weekday, from: self)
        return weekday
    }

    func getDay() -> String {
        guard let calendar = NSCalendar(calendarIdentifier: .gregorian) else { return "" }
        let day = calendar.component(.day, from: self)
        return String(day)
    }
    func getDateFor(day:Int) -> Date? {
        return Calendar.current.date(byAdding: .day, value: day, to: self)
       }

    func getFullDay() -> String {
        guard let calendar = NSCalendar(calendarIdentifier: .gregorian) else { return "" }
        let day = calendar.component(.day, from: self)
        let year = calendar.component(.year, from: self)

        let fullDay = self.dayOfTheWeek() + " \(day) " + self.monthString() + " \(year)"
        return fullDay
    }

    func getFullTime() -> String {
        guard let calendar = NSCalendar(calendarIdentifier: .gregorian) else { return "" }
        let hour = calendar.component(.hour, from: self)
        let minute = calendar.component(.minute, from: self)

        let fullTime = " \(hour) heure" + " \(minute) min"
        return fullTime
    }
    func convertTimetoXaxis() -> Double {
        guard let calendar = NSCalendar(calendarIdentifier: .gregorian) else { return 0.0 }

        let hour = calendar.component(.hour, from: self)
        let minute = calendar.component(.minute, from: self)
        let time = Double(hour) + Double((minute/60)*100)
        return time
    }
    func getDateHour() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = .current
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

            //according to date format your date string
        let date = dateFormatter.string(from: self)
        return date
        }
    func getDate() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = .current
            dateFormatter.dateFormat = "yyyy-MM-dd"

            //according to date format your date string
        let date = dateFormatter.string(from: self)
        return date
        }
}

