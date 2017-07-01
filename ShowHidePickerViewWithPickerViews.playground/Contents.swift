import UIKit
import PlaygroundSupport


class Responder: NSObject {
    func pokemonShowButtonPressed(sender: UIButton) {
        print("pokemon show pressed")
        
        if pokemonImageView.isHidden == true {
            UIView.animate(withDuration: 0.3, animations: {
                pokemonImageView.isHidden = false
                pokemonShowButton.isHidden = true
                pokemonHideButton.isHidden = false
            }) { (_) in
                
            }
        }
    }
    
    func pokemonHideButtonPressed(sender: UIButton) {
        print("pokemon hideButton pressed")
        if pokemonImageView.isHidden == false {
            UIView.animate(withDuration: 0.3, animations: {
                pokemonImageView.isHidden = true
                pokemonShowButton.isHidden = false
                pokemonHideButton.isHidden = true
            }) { (_) in
                
            }
        }
    }
    func nikeShowButtonPressed(sender: UIButton) {
        print("nike show pressed")
        
        if nikeImageView.isHidden == true {
            UIView.animate(withDuration: 0.3, animations: {
                nikeImageView.isHidden = false
                nikeShowButton.isHidden = true
                nikeHideButton.isHidden = false
            }) { (_) in
                
            }
        }
    }
    
    func nikeHideButtonPressed(sender: UIButton) {
        print("nike hideButton pressed")
        if nikeImageView.isHidden == false {
            UIView.animate(withDuration: 0.3, animations: {
                nikeImageView.isHidden = true
                nikeShowButton.isHidden = false
                nikeHideButton.isHidden = true
            }) { (_) in
                
            }
        }
    }
    
}

// Create a Container View for the Playground
let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 667))
containerView.backgroundColor = .white

// Create a responder that responds to buttons events
let responder = Responder()


// Create Views

// StackViews used: 
//      stackview - is the root stackview that will vertically hold the content views. We use a backgroundView in the stackview to see it
//      pokemonButtonsStackview & nikeButtonsStackview - are the stackview that will horizontally hold the buttons (hide and show content)

let stackview = UIStackView()
stackview.axis = .vertical
stackview.distribution = .fill
stackview.alignment = .fill
stackview.spacing = 0
stackview.translatesAutoresizingMaskIntoConstraints = false

let stackviewBackgroundView = UIView()
stackviewBackgroundView.backgroundColor = UIColor.purple
stackviewBackgroundView.translatesAutoresizingMaskIntoConstraints = false


let pokemonButtonsStackview = UIStackView()
pokemonButtonsStackview.axis = .horizontal
pokemonButtonsStackview.distribution = .fillEqually
pokemonButtonsStackview.alignment = .top    // This is the key property for properly aligning the buttons to the top of the view provided by the vertical stackview!!!
pokemonButtonsStackview.spacing = 0
pokemonButtonsStackview.translatesAutoresizingMaskIntoConstraints = false

let nikeButtonsStackview = UIStackView()
nikeButtonsStackview.axis = .horizontal
nikeButtonsStackview.distribution = .fillEqually
nikeButtonsStackview.alignment = .top
nikeButtonsStackview.spacing = 0
nikeButtonsStackview.translatesAutoresizingMaskIntoConstraints = false


// First Section
let pokemonShowButton = UIButton()
pokemonShowButton.setTitle("show pokemon", for: .normal)
pokemonShowButton.backgroundColor = UIColor.blue
pokemonShowButton.setTitleColor(UIColor.white, for: .normal)
pokemonShowButton.addTarget(responder, action: #selector(Responder.pokemonShowButtonPressed), for: .touchUpInside)
pokemonShowButton.isHidden = false

let pokemonHideButton = UIButton()
pokemonHideButton.setTitle("hide pokemon", for: .normal)
pokemonHideButton.backgroundColor = UIColor.red
pokemonHideButton.setTitleColor(UIColor.white, for: .normal)
pokemonHideButton.addTarget(responder, action: #selector(Responder.pokemonHideButtonPressed), for: .touchUpInside)
pokemonHideButton.isHidden = true

let pokemonImage = UIImage(named: "celebi.jpg")
let pokemonImageView = UIImageView(image: pokemonImage)
pokemonImageView.contentMode = .scaleAspectFit
pokemonImageView.isHidden = true


// Second Section
let nikeImage = UIImage(named: "likeaboss.jpeg")
let nikeImageView = UIImageView(image: nikeImage)
nikeImageView.contentMode = .scaleAspectFit
nikeImageView.isHidden = true

let nikeShowButton = UIButton()
nikeShowButton.setTitle("show logo", for: .normal)
nikeShowButton.backgroundColor = UIColor.blue
nikeShowButton.setTitleColor(UIColor.white, for: .normal)
nikeShowButton.addTarget(responder, action: #selector(Responder.nikeShowButtonPressed), for: .touchUpInside)
nikeShowButton.isHidden = false

let nikeHideButton = UIButton()
nikeHideButton.setTitle("hide logo", for: .normal)
nikeHideButton.backgroundColor = UIColor.red
nikeHideButton.setTitleColor(UIColor.white, for: .normal)
nikeHideButton.addTarget(responder, action: #selector(Responder.nikeHideButtonPressed), for: .touchUpInside)
nikeHideButton.isHidden = true



// View Hierarchy
containerView.addSubview(stackview)
stackview.addArrangedSubview(pokemonButtonsStackview)
stackview.insertSubview(stackviewBackgroundView, at: 0) // Background

pokemonButtonsStackview.addArrangedSubview(pokemonShowButton)
pokemonButtonsStackview.addArrangedSubview(pokemonHideButton)
stackview.addArrangedSubview(pokemonImageView)

nikeButtonsStackview.addArrangedSubview(nikeShowButton)
nikeButtonsStackview.addArrangedSubview(nikeHideButton)
stackview.addArrangedSubview(nikeButtonsStackview)
stackview.addArrangedSubview(nikeImageView)




// Constraints 
stackview.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0).isActive = true
stackview.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0).isActive = true
stackview.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
//stackview.heightAnchor.constraint(equalToConstant: 200).isActive = true

stackviewBackgroundView.leadingAnchor.constraint(equalTo: stackview.leadingAnchor, constant: 0).isActive = true
stackviewBackgroundView.trailingAnchor.constraint(equalTo: stackview.trailingAnchor, constant: 0).isActive = true
stackviewBackgroundView.topAnchor.constraint(equalTo: stackview.topAnchor, constant: 0).isActive = true
stackviewBackgroundView.bottomAnchor.constraint(equalTo: stackview.bottomAnchor, constant: 0).isActive = true


// change ImageViews size


PlaygroundPage.current.liveView = containerView
