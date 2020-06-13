
struct DetailActionsItem {
    var isFave: Bool
    let favouriteAction: (Bool) -> Void
    let toDoAction: (Bool) -> Void
    let shareAction: () -> Void
}
