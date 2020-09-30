import Foundation

struct ClockTime {
    static let AM7 = "7:00 am"
    static let AM9 = "9:00 am"
    static let AM10 = "10:00 am"
    static let PM1 = "1:00 pm"
    static let PM4 = "4:00 pm"
    static let PM7 = "7:00 pm"
    static let PM10 = "10:00 pm"
}
protocol ClockObserverProtocol {
    var id:Int { get set }
    func ClockTimed(time:String)
}

class StudentTimeTable: ClockObserverProtocol{
    var id: Int
    
    init( _id:Int) {
        id = _id
    }
    
    func ClockTimed(time: String) {
        switch time {
        case ClockTime.AM7:
            print("Wake up Time - Student")
        case ClockTime.AM9:
            print("Get Ready for School - Student")
        case ClockTime.AM10:
            print("Going School - Student")
        case ClockTime.PM1:
            print("lunch Time - Student")
        case ClockTime.PM4:
            print("Going back to Home - Student")
        case ClockTime.PM10:
            print("Sleep Time - Student")
        default:
            print("This timing is not set - Student")
        }
    }
    
}

class EmployeeTimeTable:ClockObserverProtocol {
    var id: Int
    
    init( _id:Int) {
        id = _id
    }
    
    func ClockTimed(time: String) {
        switch time {
        case ClockTime.AM7:
            print("Wake up Time - Employee")
        case ClockTime.AM9:
            print("Get Ready for Office - Employee")
        case ClockTime.AM10:
            print("Going Office - Employee")
        case ClockTime.PM1:
            print("lunch Time - Employee")
        case ClockTime.PM4:
            print("Tea break - Employee")
        case ClockTime.PM7:
            print("Going back to Home - Employee")
        case ClockTime.PM10:
            print("Sleep Time - Employee")
        default:
            print("This timing is not set - Employee")
        }
    }
}
    class ClockChangeSubject {
        private var _time = String()
        var clockTime : String {
            get {
                return _time
            }
            set (newTime) {
                _time = newTime
                notifyObserver(_time: _time)
            }
        }
        var allObserver = [ClockObserverProtocol]()
        func addObserver(observer:ClockObserverProtocol) {
            guard !allObserver.contains(where: {$0.id == observer.id}) else {
                return
            }
            allObserver.append(observer)
        }
        func removeObserver(observer:ClockObserverProtocol){
            allObserver = allObserver.filter({$0.id != observer.id})
        }
        func notifyObserver(_time:String) {
            allObserver.forEach({$0.ClockTimed(time: _time)})
        }
        deinit {
            allObserver.removeAll()
        }
    }
        
        let obseverSubject = ClockChangeSubject()
        let empOb = EmployeeTimeTable(_id: 1)
        let stuOb = StudentTimeTable(_id: 2)
        
obseverSubject.addObserver(observer: empOb)
obseverSubject.addObserver(observer: stuOb)

obseverSubject.clockTime = ClockTime.AM7
print("-----")

obseverSubject.clockTime = ClockTime.PM4
print("-----")

obseverSubject.clockTime = ClockTime.PM7

obseverSubject.removeObserver(observer: stuOb)
print("-----")

obseverSubject.clockTime = ClockTime.PM10
