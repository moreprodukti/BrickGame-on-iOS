import UIKit

protocol GameViewDelegate: AnyObject {
    func backButtonTapped()
    func pauseButtonTapped()
}

class GameViewController: UIViewController {
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

    lazy private var gameBoard: GameBoardView = {
        return $0
    }(GameBoardView())
    lazy private var backButton = createButton(text: "◀️ Go back", action: backAction)
    lazy private var pause = createButton(text: "Pause ⏸️", action: pauseAct)
    lazy private var soundButton = createButton(text: soundState.emoji, action: soundAct)
    private var soundState: SoundState = .on
    
    lazy private var backAction: UIAction = UIAction { [weak self] _ in
        self?.dismiss(animated: false)
    }
    
    lazy private var pauseAct: UIAction = UIAction { [weak self] _ in
        print("тык")
    }
    
    lazy private var soundAct: UIAction = UIAction { [weak self] _ in
        self?.updateSoundButton()
    }
    
    lazy private var infoPanel: UIView = {
        $0.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        $0.layer.cornerRadius = 12

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
        
        $0.addSubview(labelsStack)
        
        labelsStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            labelsStack.topAnchor.constraint(equalTo: $0.topAnchor, constant: 12),
            labelsStack.bottomAnchor.constraint(equalTo: $0.bottomAnchor, constant: -12),
            labelsStack.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 20),
            labelsStack.trailingAnchor.constraint(equalTo: $0.trailingAnchor, constant: -20),
        ])
        
        return $0
    }(UIView())

    init(delegate: GameViewDelegate? = nil, soundState: SoundState = .on) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
        self.soundState = soundState
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        view.backgroundColor = UIColor(named: "Background")

        view.addSubview(gameBoard)
        view.addSubview(backButton)
        view.addSubview(pause)
        view.addSubview(infoPanel)
        view.addSubview(soundButton)
    }

    private func createButton(text: String, action: UIAction) -> UIButton {
        let button = UIButton(primaryAction: action)
        button.setTitle(text, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        button.layer.cornerRadius = 12
        return button
    }

    private func setupConstraints() {
        backButton.translatesAutoresizingMaskIntoConstraints = false
        pause.translatesAutoresizingMaskIntoConstraints = false
        soundButton.translatesAutoresizingMaskIntoConstraints = false
        gameBoard.translatesAutoresizingMaskIntoConstraints = false
        infoPanel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            backButton.widthAnchor.constraint(equalToConstant: 100),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            
            soundButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            soundButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 8),
            soundButton.widthAnchor.constraint(equalToConstant: 40),
            soundButton.heightAnchor.constraint(equalToConstant: 40),
            
            pause.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            pause.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            pause.widthAnchor.constraint(equalToConstant: 85),
            pause.heightAnchor.constraint(equalToConstant: 40),
            
            gameBoard.topAnchor.constraint(equalTo: pause.bottomAnchor, constant: 10),
            gameBoard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            gameBoard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            gameBoard.bottomAnchor.constraint(equalTo: infoPanel.topAnchor, constant: -10),
            
            infoPanel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            infoPanel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            infoPanel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
//            infoPanel.heightAnchor.constraint(equalToConstant: 80)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        updateSoundButton()
    }
}
