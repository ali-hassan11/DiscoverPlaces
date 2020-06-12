
enum Icon: String {
    
    case browser = "globe"
    case disclosureIndicator = "chevron.right"
    case mapPin = "mappin.and.ellipse"
    case phone = "phone.circle.fill"
    case time = "clock.fill"

    //Make sure to check that I've icons for every type of cell
    
    var name: String {
        return rawValue
    }
    
}

