import UIKit

class GameViewController: UIViewController {
    private let gameView = GameView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadView() {
        view = gameView
        setupGameBoard()
    }

    private func setupGameBoard() {
        gameView.delegate = self
    }
}

extension GameViewController: GameViewDelegate {
    func backButtonTapped() {
        dismiss(animated: false)
    }

    func pauseButtonTapped() {}
}
