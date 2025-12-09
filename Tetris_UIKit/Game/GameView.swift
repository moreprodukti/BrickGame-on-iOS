import UIKit

protocol GameViewDelegate: AnyObject {
    func backButtonTapped()
    func pauseButtonTapped()
}

class GameView: UIView {
    enum SoundState {
        case on
        case off

        var emoji: String {
            switch self {
            case .on: return "🔈"
            case .off: return "🔇"
            }
        }

        var opposite: SoundState {
            switch self {
            case .on: return .off
            case .off: return .on
            }
        }
    }

    weak var delegate: GameViewDelegate?

    private let gameBoard = GameBoardView()
    private let backButton = UIButton(type: .system)
    private let pause = UIButton(type: .system)
    private let soundButton = UIButton(type: .system)
    private var soundState: SoundState = .on
    private let infoPanel = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        createInfoPanel()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        createInfoPanel()
        setupConstraints()
    }

    private func setupView() {
        backgroundColor = UIColor(named: "Background")
        setupBackButton()
        setPause()
        setSoundButton()

        addSubview(gameBoard)
        addSubview(backButton)
        addSubview(pause)
        addSubview(infoPanel)
        addSubview(soundButton)
    }

    private func createInfoPanel() {
        infoPanel.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        infoPanel.layer.cornerRadius = 12

        let score = createLabel(text: "Score: 100")
        let level = createLabel(text: "Level: 1")

        let hStack1 = UIStackView(arrangedSubviews: [score, level])
        hStack1.axis = .vertical
        hStack1.spacing = 10
        hStack1.distribution = .fillEqually

        let nextTxt = createLabel(text: "Next:")
        let next = createLabel(text: "🟥🟥🟥🟥")

        let hStack2 = UIStackView(arrangedSubviews: [nextTxt, next])
        hStack2.axis = .vertical
        hStack2.spacing = 10
        hStack2.distribution = .fillEqually
        hStack2.alignment = .center

        let labelsStack = UIStackView(arrangedSubviews: [hStack1, hStack2])
        labelsStack.axis = .horizontal
        labelsStack.spacing = 15
        labelsStack.alignment = .fill

        labelsStack.translatesAutoresizingMaskIntoConstraints = false
        infoPanel.addSubview(labelsStack)

        NSLayoutConstraint.activate([
            labelsStack.topAnchor.constraint(equalTo: infoPanel.topAnchor, constant: 12),
            labelsStack.bottomAnchor.constraint(equalTo: infoPanel.bottomAnchor, constant: -12),
            labelsStack.leadingAnchor.constraint(equalTo: infoPanel.leadingAnchor, constant: 20),
            labelsStack.trailingAnchor.constraint(equalTo: infoPanel.trailingAnchor, constant: -20),
        ])

        infoPanel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupBackButton() {
        backButton.setTitle("◀️ Go back", for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        backButton.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        backButton.layer.cornerRadius = 12

        // Добавляем действие для возврата
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
    }

    private func setPause() {
        pause.setTitle("Pause ⏸️", for: .normal)
        pause.setTitleColor(.white, for: .normal)
        pause.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        pause.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        pause.layer.cornerRadius = 12
    }

    private func setSoundButton() {
        soundButton.setTitle(soundState.emoji, for: .normal)
        soundButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        soundButton.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        soundButton.layer.cornerRadius = 12

        soundButton.addTarget(self, action: #selector(soundButtonTapped), for: .touchUpInside)

        updateSoundButton()
    }

    private func setupConstraints() {
        gameBoard.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        pause.translatesAutoresizingMaskIntoConstraints = false
        soundButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            infoPanel.widthAnchor.constraint(equalToConstant: 300),
            infoPanel.heightAnchor.constraint(equalToConstant: 80),
            infoPanel.centerXAnchor.constraint(equalTo: centerXAnchor),
            infoPanel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),

            gameBoard.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 70),
            gameBoard.centerXAnchor.constraint(equalTo: centerXAnchor),
            gameBoard.widthAnchor.constraint(equalToConstant: 300),
            gameBoard.heightAnchor.constraint(equalToConstant: 600),

            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            backButton.widthAnchor.constraint(equalToConstant: 100),
            backButton.heightAnchor.constraint(equalToConstant: 40),

            pause.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            pause.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            pause.widthAnchor.constraint(equalToConstant: 85),
            pause.heightAnchor.constraint(equalToConstant: 40),

            soundButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            soundButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 8),
            soundButton.widthAnchor.constraint(equalToConstant: 40),
            soundButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    private func createLabel(text: String) -> UILabel {
        let label = UILabel()

        label.text = text
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)

        return label
    }

    private func updateSoundButton() {
        soundButton.setTitle(soundState.emoji, for: .normal)
    }

    @objc private func backButtonAction() {
        delegate?.backButtonTapped()
    }

    @objc private func soundButtonTapped() {
        soundState = soundState.opposite

        soundButton.setTitle(soundState.emoji, for: .normal)
    }
}
