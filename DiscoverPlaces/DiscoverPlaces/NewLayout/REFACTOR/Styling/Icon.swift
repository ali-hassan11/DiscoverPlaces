
enum Icon: String {
    
    case browser = "globe"
    case toDoFilled = "bookmark.fill"
    case toDoOutline = "bookmark"
    case disclosureIndicator = "chevron.right"
    case heartFilled = "heart.fill"
    case heartOutline = "heart"
    case mapPin = "mappin.and.ellipse"
    case phone = "phone.circle.fill"
    case share = "square.and.arrow.up"
    case time = "clock.fill"

    //Make sure to check that I've icons for every type of cell
    
    var name: String {
        return rawValue
    }
    
}

