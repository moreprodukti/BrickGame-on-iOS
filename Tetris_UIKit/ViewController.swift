import UIKit
import Foundation

class ViewController: UIViewController {
    lazy private var logoImageView: UIImageView = {
        $0.image = UIImage(named: "tetris")
        $0.frame = CGRect(x: view.frame.width / 2 - 160, y: view.frame.height / 3, width: 320, height: 100)
        
        return $0
    }(UIImageView())
    
    lazy private var startButton: UIButton = {
        $0.setTitle("PLAY", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor.gray
        $0.layer.cornerRadius = 12
        $0.frame = CGRect(x: view.frame.width / 2 - 160, y: logoImageView.frame.maxY + 10, width: 320, height: 70)
        
        return $0
    }(UIButton())

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = UIColor(named: "Background")

        view.addSubview(logoImageView)
        
        view.addSubview(startButton)

        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    @objc private func startButtonTapped() {
        // Анимация нажатия
        UIView.animate(withDuration: 0.1, animations: {
            self.startButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1) {
                self.startButton.transform = .identity
            }

            // Вызываем переход через 0.1 секунды
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.showGameScreen()
            }
        })
    }

    private func showGameScreen() {
        // 1. Создаем экземпляр игрового экрана
        let gameViewController = GameViewController(soundState: .on)

        // 2. Настраиваем способ презентации
        let navigationController = UINavigationController(rootViewController: gameViewController)
        navigationController.modalPresentationStyle = .fullScreen

        // 3. Показываем экран
        present(navigationController, animated: false) {}
    }
}
