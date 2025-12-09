import UIKit

class GameBoardView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }

    private func setView() {
        backgroundColor = UIColor(named: "Background")
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
    }
}
