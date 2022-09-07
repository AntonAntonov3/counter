//
//  ViewController.swift
//  Counter
//
//  Created by Александр Рыбников on 01.09.2022.
//



import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var counterButton: UIButton!
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var clearButton: UIButton!
    @IBOutlet private weak var counterTwoButton: UIButton!
    @IBOutlet private weak var factorSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var valueLabel: UILabel!
    @IBOutlet private weak var motivationLabel: UILabel!
    private var count: Int = 0
    private var factorCount: Int = 1
    private var timer = Timer()
    
    // Мотивационный текст
    private var motivationWords = ["Молодец!", "Ты сможешь!", "Так держать!", "Don't stop!", "Just Do It!", "Только вперед!", "Не останавливайся!", "Я в тебя верю!", "У тебя все получится!"]
    // Почти мотивационный текст
    private var demotivationWords = ["Поднажми", "Ты можешь больше!", "Не подводи маму!", "Отрицательный рост, тоже рост", "Бывало и лучше", "Может это не твое?", "Сходи отдохни", "Со всеми бывает", "А разговоров то было", "Сделаем вид, что этого не было"]
    
    //Создаем свои цвета
    private let colorClearButton = UIColor(red: 1, green: 0.0, blue: 0.0, alpha: 0.7)
    private let colorBackground = UIColor(red: 1, green: 0.55, blue: 0.0, alpha: 1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        clearButton.isHidden = true
        factorSegmentedControl.selectedSegmentIndex = 0
        
        //Редактирование визуалицаии лейбла и кнопок
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        valueLabel.text = "" // В ТЗ должно быть написано "Значение счетчика:" но так не красиво
        valueLabel.textColor = .white
        valueLabel.textAlignment = .center
        valueLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 23.0)
        
        
        counterLabel.textColor = .white
        counterLabel.font = counterLabel.font.withSize(100)
        counterLabel.text = "\(count)"
        
        
        counterButton.backgroundColor = colorBackground
        counterButton.layer.cornerRadius = 20
        
        counterTwoButton.backgroundColor = colorBackground
        counterTwoButton.layer.cornerRadius = 20
        
        
        clearButton.backgroundColor = colorClearButton
        clearButton.setTitle(" RESET", for: .normal)
        clearButton.setTitleColor(.white, for: .normal)
        clearButton.layer.cornerRadius = 10
        
        motivationLabel.textAlignment = .center
        motivationLabel.textColor = .white
        motivationLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 23.0)
        motivationLabel.text = ""
        
        factorSegmentedControl.selectedSegmentTintColor = .systemGreen
    }
    
    
    // Выбираем множитель
    @IBAction private func didTapFactorSegmentControl(_ sender: UISegmentedControl) {
        
        if factorSegmentedControl.selectedSegmentIndex == 0{
            factorCount = 1
            factorSegmentedControl.selectedSegmentTintColor = .systemGreen
        }else if factorSegmentedControl.selectedSegmentIndex == 1{
            factorCount = 3
            factorSegmentedControl.selectedSegmentTintColor = .systemOrange
        }else if factorSegmentedControl.selectedSegmentIndex == 2{
            factorCount = 10
            factorSegmentedControl.selectedSegmentTintColor = .systemRed
        }
    }
    
    
    //Увелечение count или сброс значения, в зависимости от выбранной кнопки
    @IBAction private func increaseNumber(_ sender: UIButton) {
        clearButton.isHidden = false
        count += factorCount
        counterLabel.text = "\(count)"
        phraseSelection(x: count)
    }
    
    @IBAction private func decreaseNumber(_ sender: Any) {
        clearButton.isHidden = false
        count -= factorCount
        counterLabel.text = "\(count)"
        phraseSelection(x: count)
    }
    
    @IBAction private func resetCounter(_ sender: Any) {
        counterLabel.text = "\(count)"
        counterLabel.textColor = .white
        clearButton.isHidden = true
        factorSegmentedControl.selectedSegmentIndex = 0
        factorSegmentedControl.selectedSegmentTintColor = .systemGreen
        factorCount = 1
        motivationLabel.text = ""
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(countTimer), userInfo: nil, repeats: true)
    }
}

extension ViewController {
    
    // Выбор фразы в зависимости от значения count
    func phraseSelection (x: Int){
        switch x{
        case ..<0:
            motivationLabel.text = demotivationWords.randomElement()
            counterLabel.textColor = .red
        case 0... :
            motivationLabel.text = motivationWords.randomElement()
            counterLabel.textColor = #colorLiteral(red: 0, green: 0.8958038538, blue: 0, alpha: 1)
        default:
            break
        }
    }
    
    @objc private func countTimer(x: Double){
        
        if count>0{
            count-=1
        }else if count<0{
            count+=1
        }
        if count==0{
            timer.invalidate()
        }
        counterLabel.text = "\(count)"
    }
}




