import UIKit

class ViewController: UIViewController {
    private let logoImageView = UIImageView()
    private let startButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setLogo()
        setupStartButton()
    }

    private func setupView() {
        view.backgroundColor = UIColor(named: "Background")
    }

    private func setLogo() {
        let logo = UIImage(named: "tetris")
        logoImageView.image = logo

        view.addSubview(logoImageView)

        logoImageView.contentMode = .scaleAspectFit // Сохраняет пропорции
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),

            // Ширина - 70% от ширины экрана
            logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),

            logoImageView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }

    private func setupStartButton() {
        startButton.setTitle("PLAY", for: .normal)

        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 26, weight: .bold)

        startButton.setTitleColor(.white, for: .normal)
        startButton.backgroundColor = UIColor.gray

        startButton.layer.cornerRadius = 12
        startButton.layer.masksToBounds = true

        view.addSubview(startButton)

        // 7. Отключаем авто-констрейнты
        startButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            startButton.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: -10),

            startButton.widthAnchor.constraint(equalToConstant: 240),

            startButton.heightAnchor.constraint(equalToConstant: 60),
        ])

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
        let gameViewController = GameViewController()

        // 2. Настраиваем способ презентации
        let navigationController = UINavigationController(rootViewController: gameViewController)
        navigationController.modalPresentationStyle = .fullScreen

        // 3. Показываем экран
        present(navigationController, animated: false) {}
    }
}
