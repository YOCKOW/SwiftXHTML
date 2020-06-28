/* *************************************************************************************************
 TableElement+Calendar.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import Foundation

extension TableElement {
  public static let defaultDayCellContentGenerator: (TableDataCellElement, Int) -> Node = { _, day in
    return .text(String(day))
  }
  
  /// Generate a calendar XHTML.
  ///
  /// * parameters:
  ///    - xhtmlPrefix: The XML prefix of `table`. Default is `.none`.
  ///    - classAttributeNamePrefix: The prefix of class attribute name. Default is "calendar".
  ///    - year: The year of calendar.
  ///    - month: The month of calendar. For example, pass 10 in the case that the month is October.
  ///    - locale: The locale to be used for this calendar.
  ///    - dayCellContent: A closure to generate a content of the table cell for each days.
  ///                      The arguments of the closure are: #0 is table cell element of the day, #1 is the day.
  public static func calendar(xhtmlPrefix: QualifiedName.Prefix = .none,
                              classAttributeNamePrefix classPrefix: String = "calendar",
                              year: Int, month: Int, locale: Locale = .current,
                              dayCellContent: (TableDataCellElement, Int) -> Node = defaultDayCellContentGenerator) -> TableElement {
    let localCalendar = locale.calendar
    let weekdayNames = localCalendar.shortWeekdaySymbols
    let firstWeekday = localCalendar.firstWeekday
    
    func __localWeekdayName(atCalendarIndex index: Int) -> String {
      return weekdayNames[(firstWeekday - 1 + index) % weekdayNames.count]
    }
    
    func __calendarIndex(of weekday: Int) -> Int {
      if weekday >= firstWeekday {
        return weekday - firstWeekday
      } else {
        return weekday + weekdayNames.count - firstWeekday
      }
    }
    
    let table = try! TableElement(xhtmlPrefix: xhtmlPrefix,
                                  attributes: ["class": classPrefix])
    
    do { // Weekday names
      let thead = try! TableHeaderElement(xhtmlPrefix: xhtmlPrefix, attributes: ["class": "\(classPrefix)_weekdayNames"])
      let tr = try! TableRowElement(xhtmlPrefix: xhtmlPrefix)
      defer {
        thead.append(tr)
        table.append(thead)
      }
      
      for ii in 0..<weekdayNames.count {
        let className = "\(classPrefix)_weekdayName_\(ii)"
        let th = try! TableHeaderCellElement(
          xhtmlPrefix: xhtmlPrefix,
          attributes: ["class": className],
          children: [.text(__localWeekdayName(atCalendarIndex: ii))]
        )
        tr.append(th)
      }
    }
    
    do { // days
      let tbody = try! TableBodyElement(xhtmlPrefix: xhtmlPrefix,
                                        attributes: ["class": "\(classPrefix)_body"])
      defer {
        table.append(tbody)
      }
      
      guard let firstDay = localCalendar.date(from: DateComponents(calendar: localCalendar,
                                                                   timeZone: localCalendar.timeZone,
                                                                   year: year,
                                                                   month: month,
                                                                   day: 1))
      else {
        fatalError("Invalid year or month.")
      }
      
      let indexOfFirstDay = __calendarIndex(of: localCalendar.component(.weekday, from: firstDay))
      var finished = false
      var day: Int = 1 - indexOfFirstDay
      
      while !finished {
        let row = try! TableRowElement(xhtmlPrefix: xhtmlPrefix)
        defer { tbody.append(row) }
        
        for ii in 0..<weekdayNames.count {
          let cell = try! TableDataCellElement(xhtmlPrefix: xhtmlPrefix,
                                               attributes: ["class": "\(classPrefix)_weekday_\(ii)"])
          let date = DateComponents(calendar: localCalendar,
                                    timeZone: localCalendar.timeZone,
                                    year: year, month: month, day: day)
          if date.isValidDate(in: localCalendar) {
            cell.append(dayCellContent(cell, day))
          } else if day > 0 {
            // For example, June 31st...
            finished = true // Don't break because it is required to let the row end.
          }
          row.append(cell)
          day += 1
        }
      }
    }
    
    return table
  }
}
