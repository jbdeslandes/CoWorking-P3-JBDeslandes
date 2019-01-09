class Message {

    // MARK: - Introduction
    static func arena() {
        print("Bienvenue dans l'arène ! \n")
    } // End of arena()

    static func playerName(_ player: String) {
        print("\(player) - Quel est ton nom ?", terminator: " ")
    } // End of playerName()

    static func welcome1(_ player: String) {
        print("Force & Honneur, \(player) ! \n")
    } // End of welcome1()

    static func welcome2(_ player: String) {
        print("Esprit & Robustesse sur toi, \(player) ! \n")
    } // End of welcome2()

    // MARK: - Champions creation
    static func usedName() {
        print("Ce nom est déjà pris, veuillez recommencer. \n")
    } // End of usedName()

    static func nameChampions(_ team: Team) {
        print("\(team.player) - Choisis le nom des héros qui composeront ton équipe ! \n")
    } // End of nameChampions()

    static func name(_ num: Int) {
        print("Quel est le nom de ton champion numéro \(num) ?")
    } // End of name()

    static func choseRole(_ hero: String) {
        print()
        print("Quelle sera la classe de \(hero) ? \n"
            + "\n1. Combattant" + " - ATQ: \(Constants.SWORDDAMAGE)"
            + " / PV: \(Constants.FIGHTERLIFE)" + " - Guerrier équilibré"
            + "\n2. Magicien" + " - ATQ: \(Constants.DEAD)"
            + " / PV: \(Constants.WIZARDLIFE)" + " - Ne combat pas / Soigneur efficace"
            + "\n3. Colosse" + " - ATQ: \(Constants.FISTSDAMAGE)"
            + " / PV: \(Constants.COLOSSUSLIFE)" + " - Faible puissance / Très résistant"
            + "\n4. Nain" + " - ATQ: \(Constants.AXEDAMAGE)"
            + " / PV: \(Constants.DWARFLIFE)" + " - Grande puissance / Peu résistant")
    } // End of choseRole()

    static func roleChoiced(_ currentCharacter: Character, _ role: String) {

        switch role {
        case "1":
            print("\(currentCharacter.name) le \(currentCharacter.roleName)"
            + " attrape une épée tranchante dans le râtelier d'arme le plus proche !")
        case "2":
            print("\(currentCharacter.name) le \(currentCharacter.roleName)"
            + " invoque son septre magique !")
        case "3":
            print("\(currentCharacter.name) le \(currentCharacter.roleName)"
            + " n'a besoin d'aucune arme pour écraser ses adversaires !")
        case "4":
            print("\(currentCharacter.name) le \(currentCharacter.roleName)"
            + " se saisit de sa hache préférée !")
        default:
            print("Je n'ai pas compris votre choix."
                + " Veuillez rentrer un numéro pour choisir la classe correspondante.")
        }
        print()
    } // End of roleChoiced()

    static func team1Created(_ team1: Team) {
        print("\(team1.player) - Tes champions"
            + " \(team1.characters[1]!.name), \(team1.characters[2]!.name) et \(team1.characters[3]!.name)"
            + " atteignent l'arène et attendent leurs adversaires de pied ferme.. \n")
    } // End of team1created()

    static func team2Created(_ team2: Team) {
        print("\(team2.player) - Tes champions"
            + " \(team2.characters[1]!.name), \(team2.characters[2]!.name) et \(team2.characters[3]!.name)"
            + " rejoignent l'enceinte et font face à leurs rivaux.. \n")
    } // End of team2Created()

    static func errorChoice() {
        print("Je n'ai pas compris votre choix."
            + " Veuillez rentrer un numéro pour choisir la classe correspondante.")
        print()
    } // End of errorChoice()

    static func noRoleDuplicate() {
        print("ATTENTION: Vous possèdez déjà un champion de cette classe. Veuillez en choisir une autre !")
    } // End of noRoleDuplicate()

    // MARK: - Random Options
    static func randomStart(_ atkTeam: Team) {
        print("Le peuple a parlé ! L'équipe de \(atkTeam.player) donnera le premier assaut ! \n")
        print("QUE LE COMBAT COMMENCE ! \n")
    } // End of randomStart()

    static func randomTreasureAppears() {
        print("UN COFFRE MAGIQUE APPARAIT ! \n")
    } // End of randomTreasureAppears()

    // MARK: - Battle mode
    static func turn(_ turn: Int) {
        print("--- TOUR \(turn) --- \n")
    } // End of turn()

    static func attack1(_ atkTeam: Team) {
        print("\(atkTeam.player) - Quel champion souhaites-tu jouer ?")
    } // End of attack1()

    static func attack2(_ atkTeam: Team) {
        print("\(atkTeam.player) - Quel adversaire souhaites-tu attaquer ?")
    } // End of attack2()

    static func instantDamage(_ instantDamage: Int, _ atk: Character, _ def: Character, _ action: Int) {
        if action == 1 {
            print("\(atk.name) inflige \(instantDamage) points de dégâts à \(def.name). \n")
        } else if action == 3 {
            print("\(atk.name) soigne \(instantDamage) points de vie de \(def.name). \n")
        } else if action == 2 {
            print("\(atk.name) trouve une faille dans la défense de"
                + " \(def.name) et assène un coup critique de \(instantDamage * 2) points de dégâts ! \n")
        }
    } // End of instantDamage()

    static func dodge(_ defCharacter: Character) {
        print("\(defCharacter.name) esquive l'assaut ! \n")
    } // End of dodge()

    static func counterAttack(_ defCharacter: Character) {
        print("\(defCharacter.name) effectue une parade et contre-attaque !")
    } // End of counterAttack()

    static func deadCharacter(_ deadCharacter: Character) {
        print("\(deadCharacter.name) est mort ! \n")
    } // End of deadCharacter()

    static func heal1(_ team: Team) {
        print("\(team.player) - Quel compagnon souhaites-tu soigner ?")
    } // End of heal1()

    static func heal2(_ healCharacter: Character) {
        print("Il possède maintenant \(healCharacter.life) points de vie ! \n")
    } // End of heal2()

    static func noHeal(_ healCharacter: Character) {
        print("\(healCharacter.name) possède tous ses points de vie ! \n")
    } // End of noHeal()

    static func changeWeapon(_ atkCharacter: Character) {
        print("Quelle nouvelle arme choisira \(atkCharacter.name) le \(atkCharacter.roleName) ?"
            + "\n1. Masse - ATQ: \(Constants.MACEDAMAGEMIN) à \(Constants.MACEDAMAGEMAX) de dégâts"
            + "\n2. Dague - ATQ: \(Constants.DAGGERDAMAGEMIN) à \(Constants.DAGGERDAMAGEMAX) dégâts"
            + "\n3. Lance - ATQ: \(Constants.SPEARDAMAGEMIN) à \(Constants.SPEARDAMAGEMAX) dégâts"
            + "\n4. Refuser de changer d'arme")
    } // End of changeWeapon()

    static func weaponChoiced(_ atkCharacter: Character, _ weapon: String) {

        switch weapon {
        case "1":
            print("\(atkCharacter.name) le \(atkCharacter.roleName)"
                + " se saisit d'une imposante masse !")
        case "2":
            print("\(atkCharacter.name) le \(atkCharacter.roleName)"
                + " se saisit d'une dague mortelle !")
        case "3":
            print("\(atkCharacter.name) le \(atkCharacter.roleName)"
                + " se saisit de la lance maniable et rapide !")
        case "4":
            print("\(atkCharacter.name) le \(atkCharacter.roleName)"
                + " refuse de changer d'arme et poursuit le combat !")
        default:
            print("Je n'ai pas compris votre choix."
                + " Veuillez rentrer un numéro pour choisir l'arme correspondante.")
        }
        print()
    } // End of weaponChoiced()

    static func teamWins(_ team: Team) {
        print("\(team.player) REMPORTE LA VICTOIRE !! \n")
    } // End of teamWins()

    static func victory(_ turn: Int, _ team1: Team, _ team2: Team) {
        print("FIN DU COMBAT EN \(turn) TOURS ! \n")
        print("VICTOIRES : \(team1.player): \(team1.victory) / \(team2.player): \(team2.victory) \n")
    } // End of victory()

     // MARK: - Reset Option
    static func resetOptions() {
        print("Que souhaitez-vous faire ?"
            + "\n1. Rejouer avec les mêmes équipes"
            + "\n2. Rejouer avec des équipes différentes"
            + "\n3. Quitter le jeu")
    } // End of resetOptions()

    // MARK: - Flow controller
    static func next() {

        print("Appuyer sur Entrer pour continuer..")
        _ = readLine()

    } // End of next()
}
