//
//  ViewController.swift
//  Counter
//
//  Created by Александр Рыбников on 01.09.2022.
//




// На этот спринт выделено было 14 дней, а заканчивать его за 1 и бездельничать еще 13 мне не хотелось, поэтому вы сами виноваты, что даете так мало заданий. Так что, воооот такой у меня получился счетчик :)

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var counterButton: UIButton!
    @IBOutlet private weak var counter: UILabel!
    @IBOutlet private weak var clearButton: UIButton!
    @IBOutlet private weak var counterButtonTwo: UIButton!
    @IBOutlet private weak var factor: UISegmentedControl!
    @IBOutlet private weak var valueLabel: UILabel!
    @IBOutlet private weak var motivLabel: UILabel!
    private var count: Int = 0
    private var factorCount: Int = 1
    private var timer = Timer()
    
    // Мотивационный текст
    private var motivWords = ["Молодец!", "Ты сможешь!", "Так держать!", "Don't stop!", "Just Do It!", "У самурая нет цели, у самурая есть путь!", "Только вперед!", "Не останавливайся!", "Ты сможешь!", "Я в тебя верю!", "У тебя все получится!"]
    // Почти мотивационный текст
    private var demotivation = ["Поднажми", "Ты можешь больше!", "Не подводи маму!", "Отрицательный рост, тоже рост", "Бывало и лучше", "Сегодня просто не твой день", "Может это не твое?", "Сходи отдохни", "Со всеми бывает", "А разговоров то было", "Сделаем вид, что этого не было"]
    
    //Создаем свой цвета
    private let colorClearButton = UIColor(red: 1, green: 0.0, blue: 0.0, alpha: 0.7)
    private let colorBackground = UIColor(red: 1, green: 0.55, blue: 0.0, alpha: 1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        clearButton.isHidden = true
        factor.selectedSegmentIndex = 0
        
//Редактирование визуалицаии лейбла и кнопок
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        valueLabel.text = "" // В ТЗ должно быть написано "Значение счетчика:" но так не красиво
        valueLabel.textColor = .white
        valueLabel.textAlignment = .center
        valueLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 23.0)
        
        
        counter.textColor = .white
        counter.font = counter.font.withSize(100)
        counter.text = "\(count)"

        
        counterButton.backgroundColor = colorBackground
        counterButton.layer.cornerRadius = 20
        
        counterButtonTwo.backgroundColor = colorBackground
        counterButtonTwo.layer.cornerRadius = 20
        
        
        clearButton.backgroundColor = colorClearButton
        clearButton.setTitle(" RESET", for: .normal)
        clearButton.setTitleColor(.white, for: .normal)
        clearButton.layer.cornerRadius = 10
        
        motivLabel.textAlignment = .center
        motivLabel.textColor = .white
        motivLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 23.0)
        motivLabel.text = ""
        
        factor.selectedSegmentTintColor = .systemGreen
}
    
    
    // Выбираем множитель
    @IBAction private func factorButt(_ sender: UISegmentedControl) {
        
        switch factor.selectedSegmentIndex{
        case 0:
            factorCount = 1
            factor.selectedSegmentTintColor = .systemGreen
        case 1:
            factorCount = 3
            factor.selectedSegmentTintColor = .systemOrange
        case 2:
            factorCount = 10
            factor.selectedSegmentTintColor = .systemRed
        default:
            break
        }
    }
    
    
    //Увелечение count или сброс значения, в зависимости от выбранной кнопки
    @IBAction private func pressButton(_ sender: UIButton) {
        clearButton.isHidden = false
        
        
        if sender.tag == 0{
            count += factorCount
            counter.text = "\(count)"
            motivashion(x: count)
        }else if sender.tag == 1{
            count -= factorCount
            counter.text = "\(count)"
            motivashion(x: count)
        }else{
            counter.text = "\(count)"
            counter.textColor = .white
            clearButton.isHidden = true
            factor.selectedSegmentIndex = 0
            factor.selectedSegmentTintColor = .systemGreen
            factorCount = 1
            motivLabel.text = ""
            timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(countTimer), userInfo: nil, repeats: true)
            
            
        }
        
        
        // Выбор фразы в зависимости от значения count
        func motivashion (x: Int){
                switch x{
                case ..<0:
                    motivLabel.text = demotivation.randomElement()
                    counter.textColor = .red
                case 0... :
                    motivLabel.text = motivWords.randomElement()
                    counter.textColor = #colorLiteral(red: 0, green: 0.8958038538, blue: 0, alpha: 1)
                default:
                    break
                    
                }
 
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
            counter.text = "\(count)"
        
        }
}

    


