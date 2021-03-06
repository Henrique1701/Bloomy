//
//  SeedDataBase.swift
//  Bloomy
//
//  Created by Wilton Ramos on 26/11/20.
//

import CoreData
import UIKit

struct SeedDataBase {
    static let shared: SeedDataBase = SeedDataBase()
    
    func seed() {
    }
    
    func createIslands() {
        _ = IslandManager.shared.newIsland(withName: "Atenção Plena")
        _ = IslandManager.shared.newIsland(withName: "Lazer")
        _ = IslandManager.shared.newIsland(withName: "Pessoas Queridas")
        _ = IslandManager.shared.newIsland(withName: "Saúde")
        
        setUserToIslands()
    }
    
    func createChallenges() {
        createMindfulnessChallenges()
        createLeisureChallenges()
        createLovedsChallenges()
        createHealthChallenges()
    }
    
    func createRewards() {
    }
    
    func createUser() {
        _ = UserManager.shared.newUser(withName: "Rafa")
    }
    
    func createMindfulnessChallenges() {
        let mindfulnessChallenges = Challenges().mindfulnessChallenges
        for challenge in mindfulnessChallenges {
            if let mindfulnessChallenge = ChallengeManager.shared.createChallenge(withID: challenge["ID"]!
                                                                                  , withSummary: challenge["Summary"]!) {
                mindfulnessChallenge.challengeToIsland = IslandManager.shared.getIsland(withName: "Atenção Plena")
                _ = IslandManager.shared.saveContext()
            } else {
                print("Challenge \(challenge["ID"] ?? "") da Ilha Atenção Plena não foi criado")
            }
            
        }
    }
    
    func createMindfulnessRewards() {
        let mindfulnessRewards = Rewards().mindfulnessRewards
        for reward in mindfulnessRewards {
            if let mindfulnessReward = RewardManager.shared.newReward(withId: reward["ID"]!) {
                mindfulnessReward.rewardToIsland = IslandManager.shared.getIsland(withName: IslandsNames.mindfulness.rawValue)
            } else {
                print("Reward \(reward["ID"] ?? "") da Ilha Atenção Plena não foi criado")
            }
        }
    }
    
    func createLeisureChallenges() {
        let leisureChallenges = Challenges().leisureChallenges
        for challenge in leisureChallenges {
            if let leisureChallenge = ChallengeManager.shared.createChallenge(withID: challenge["ID"]!
                                                                              , withSummary: challenge["Summary"]!) {
                leisureChallenge.challengeToIsland = IslandManager.shared.getIsland(withName: "Lazer")
                _ = IslandManager.shared.saveContext()
            } else {
                print("Challenge \(challenge["ID"] ?? "") da Ilha Lazer não foi criado")
            }
        }
    }
    
    func createLeisureRewards() {
        let leisureRewards = Rewards().leisureRewards
        for reward in leisureRewards {
            if let leisureReward = RewardManager.shared.newReward(withId: reward["ID"]!) {
                leisureReward.rewardToIsland = IslandManager.shared.getIsland(withName: IslandsNames.leisure.rawValue)
            } else {
                print("Reward \(reward["ID"] ?? "") da Ilha Lazer não foi criado")
            }
        }
    }

    func createLovedsChallenges() {
        let lovedsChallenges = Challenges().lovedsChallenges
        for challenge in lovedsChallenges {
            if let lovedsChallenge = ChallengeManager.shared.createChallenge(withID: challenge["ID"]!
                                                                             , withSummary: challenge["Summary"]!) {
                lovedsChallenge.challengeToIsland = IslandManager.shared.getIsland(withName: "Pessoas Queridas")
                _ = IslandManager.shared.saveContext()
            } else {
                print("Challenge \(challenge["ID"] ?? "") da Ilha Pessoas Queridas não foi criado")
            }
        }
    }
    
    func createLovedsRewards() {
        let lovedsRewards = Rewards().lovedsRewards
        for reward in lovedsRewards {
            if let lovedsReward = RewardManager.shared.newReward(withId: reward["ID"]!) {
                lovedsReward.rewardToIsland = IslandManager.shared.getIsland(withName: IslandsNames.loveds.rawValue)
            } else {
                print("Reward \(reward["ID"] ?? "") da Ilha Pessoas Queridas não foi criado")
            }
        }
    }
    
    func createHealthChallenges() {
        let healthChallenges = Challenges().healthChallenges
        for challenge in healthChallenges {
            if let healthChallenge = ChallengeManager.shared.createChallenge(withID: challenge["ID"]!
                                                                             , withSummary: challenge["Summary"]!) {
                healthChallenge.challengeToIsland = IslandManager.shared.getIsland(withName: "Saúde")
                _ = IslandManager.shared.saveContext()
            } else {
                print("Challenge \(challenge["ID"] ?? "") da Ilha Saúde não foi criado")
            }
        }
    }
    
    func createHealthRewards() {
        let healthRewards = Rewards().healthRewards
        for reward in healthRewards {
            if let healthReward = RewardManager.shared.newReward(withId: reward["ID"]!) {
                healthReward.rewardToIsland = IslandManager.shared.getIsland(withName: IslandsNames.health.rawValue)
            } else {
                print("Reward \(reward["ID"] ?? "") da Ilha Saúde não foi criado")
            }
        }
    }
    
    func setUserToIslands() {
        if let user = UserManager.shared.getUser() {
            _ = IslandManager.shared.setUser(islandName: "Atenção Plena", user: user)
            _ = IslandManager.shared.setUser(islandName: "Lazer", user: user)
            _ = IslandManager.shared.setUser(islandName: "Pessoas Queridas", user: user)
            _ = IslandManager.shared.setUser(islandName: "Saúde", user: user)
        }
    }
}

struct Challenges {
    
    let mindfulnessChallenges = [
        ["ID": "M0", "Summary": "Pare por um momento e note os sons aos seu redor. O que você consegue ouvir?"], //ok
        ["ID": "M1", "Summary": "Durante alguma das suas refeições de hoje, preste atenção apenas no que você está comendo. Sem celular, sem televisão. Saboreie cada pedaço com atenção plena"], //ok
        ["ID": "M2", "Summary": "Observe a sua respiração. Note o ar entrando e saindo dos seus pulmões. Observe como você está se sentindo"], //ok
        ["ID": "M3", "Summary": "Olhe ao seu redor e preste atenção nos detalhes das coisas que você vê. Quais cores, formas e textura você nota?"], //ok
        ["ID": "M4", "Summary": "Feche os olhos e imagine que você está escaneando o seu corpo, da cabeça até os pés. Preste atenção nas sensações. Relaxe as áreas do seu corpo que você sentir que estão tensionadas"], //ok
        ["ID": "M5", "Summary": "Respire profundamente, levando o ar para a sua barriga"], //ok
        ["ID": "M6", "Summary": "Quando você for escovar os dentes hoje, preste atenção no seu corpo e nos movimentos que você faz. Gentilmente retorne a sua atenção quando você notar que se distraiu"], //ok
        ["ID": "M7", "Summary": "Preste atenção em um objeto ao seu redor e o observe como se o estivesse vendo pela primeira vez"], //ok
        ["ID": "M8", "Summary": "Note a beleza de algo ao seu redor. Pode ser algo da natureza, uma pessoa, um objeto, uma música"],
        ["ID": "M9", "Summary": "Respire fundo 5 vezes, puxando e soltando o ar levemente"],
        ["ID": "M10", "Summary": "Feche os olhos e preste atenção em quais superfícies seu corpo está se apoiando nesse momento"],
        ["ID": "M11", "Summary": "Feche os olhos e preste atenção em quais cheiros você consegue sentir no momento"],
        ["ID": "M12", "Summary": "Reserve um momento para massagear sua cabeça e preste atenção nas sensações sentidas nesse momento"],
        ["ID": "M13", "Summary": "Escolha uma música que te acalma e a escute de olhos fechados, prestando atenção somente na música"],
        ["ID": "M14", "Summary": "Esqueça as preocupações por um momento. Olhe por uma janela e preste atenção nos detalhes da vista"],
        ["ID": "M15", "Summary": "Tente fechar os olhos e lembrar de uma paisagem que você já viu. Pense detalhadamente nas características daquele lugar"],
        ["ID": "M16", "Summary": "Usando seus dedos, conte 10 motivos de gratidão na sua vida"],
        ["ID": "M17", "Summary": "Pare e pense sobre como você está se sentindo nesse momento. O que causou essas sensações? O que pode melhorá-las?"],
        ["ID": "M18", "Summary": "Escolha uma música calma e, durante ela, realize exercícios de respiração"],
        ["ID": "M19", "Summary": "Inspire por 4 segundos, prenda o ar por 2 e solte tudo em 6 segundos. Repita esse exercício algumas vezes"],
        ["ID": "M20", "Summary": "Deite e coloque algo leve em cima do seu estômago. Respire profundamente algumas vezes e note a subida e descida daquele objeto"],
        ["ID": "M21", "Summary": "Desenhe uma onda e passe seu dedo pelo papel. Nos picos da onda, inspire. Nas descidas, expire"],
        ["ID": "M22", "Summary": "Inspire por 4 segundos, segure o ar por mais 4 e expire novamente durante 4 segundos. Espere 4 segundos e repita o processo algumas vezes"]
        
    ]
    
    let leisureChallenges = [
        ["ID": "L0", "Summary": "Ouça sua música favorita"],
        ["ID": "L1", "Summary": "Ouça uma música que você gostava muito há alguns anos"],
        ["ID": "L2", "Summary": "Ouça uma música que você saiba de cor"],
        ["ID": "L3", "Summary": "Vá para um cômodo vazio e dance como você não dançaria na frente dos outros"],
        ["ID": "L4", "Summary": "Assista um vídeo de comédia no YouTube"],
        ["ID": "L5", "Summary": "Guarde 5 minutos do seu dia para olhar memes na internet"],
        ["ID": "L6", "Summary": "Faça um desenho simples e pinte-o do jeito que quiser"],
        ["ID": "L7", "Summary": "Assista um episódio de série que você nunca viu, mas sempre teve vontade de ver"],
        ["ID": "L8", "Summary": "Assista um vídeo de um canal que você não conhecia no YouTube"],
        ["ID": "L9", "Summary": "Escolha um filme para você não deixar de assistir no próximo fim de semana"],
        ["ID": "L10", "Summary": "Passe 5 minutos fazendo massagem no próprio pé"],
        ["ID": "L11", "Summary": "Abrace um bichinho de estimação ou veja vídeos fofos de cães na internet"],
        ["ID": "L12", "Summary": "Lanche sua comida favorita"],
        ["ID": "L13", "Summary": "Faça uma playlist para escutar durante sua próxima refeição"],
        ["ID": "L14", "Summary": "Faça uma playlist para seu próximo banho"],
        ["ID": "L15", "Summary": "Tire um momento do dia para refletir sobre a última conversa muito engraçada que você teve"],
        ["ID": "L16", "Summary": "Leia um pedacinho do seu livro favorito"],
        ["ID": "L17", "Summary": "Vista um look que te faz se sentir confiante"],
        ["ID": "L18", "Summary": "Dê uma pequena caminhada, nem que seja uma volta no seu quarteirão"],
        ["ID": "L19", "Summary": "Chame seus amigos para uma partida online de um jogo que vocês gostam"],
        ["ID": "L20", "Summary": "Procure uma ideia de DIY para você fazer essa semana"],
        ["ID": "L21", "Summary": "Coma algo de um restaurante que você não conhecia"],
        ["ID": "L22", "Summary": "Tome um banho à luz de velas"],
        ["ID": "L23", "Summary": "Junte vários travesseiros de uma maneira confortável e tire uma soneca"],
        ["ID": "L24", "Summary": "Pense na sua flor favorita e tente desenhá-la da sua maneira"],
        ["ID": "L25", "Summary": "Guarde 5 minutos do seu dia para olhar o pôr do sol"],
        ["ID": "L26", "Summary": "Tente uma nova receita"],
        ["ID": "L27", "Summary": "Enquanto realizando alguma atividade rotineira, tente escutar um podcast"],
        ["ID": "L28", "Summary": "Hoje, enquanto estiver numa rede social, pare de acompanhar pessoas que tragam algum tipo de ansiedade"],
        ["ID": "L29", "Summary": "Tente substituir redes sociais por outra atividade hoje"],
        ["ID": "L30", "Summary": "Assista a um episódio de uma série de comédia "],
        ["ID": "L31", "Summary": "Leia frases motivacionais"],
        ["ID": "L32", "Summary": "Assista uma entrevista com seu famoso favorito"],
        ["ID": "L33", "Summary": "Faça algo que aumenta sua autoestima hoje"],
        ["ID": "L35", "Summary": "Faça uma lista dos melhores momentos desse ano"]
    ]
    
    let lovedsChallenges = [
        ["ID": "P0", "Summary": "Mande um meme ou um vídeo engraçado para alguém"],
        ["ID": "P1", "Summary": "Mande mensagem para um amigo relembrando algum momento muito especial que vocês viveram juntos"],
        ["ID": "P2", "Summary": "Fale para alguém como essa pessoa é especial"],
        ["ID": "P3", "Summary": "Elogie duas pessoas que você ama"],
        ["ID": "P4", "Summary": "Troque indicações de música com alguém "],
        ["ID": "P5", "Summary": "Mande mensagem para um amigo com quem você não fala há muito tempo perguntando como ele está"],
        ["ID": "P6", "Summary": "Mande um doce por delivery para alguém de surpresa"],
        ["ID": "P7", "Summary": "Faça alguma surpresa para alguém que você ama"],
        ["ID": "P8", "Summary": "Cozinhe uma refeição especial para alguém"],
        ["ID": "P9", "Summary": "Compre um presente para uma pessoa querida"],
        ["ID": "P10", "Summary": "Mande uma mensagem de bom dia"],
        ["ID": "P11", "Summary": "Abrace alguém"],
        ["ID": "P12", "Summary": "Mande uma mensagem de gratidão pela pelo apoio de alguém na sua vida"],
        ["ID": "P13", "Summary": "Pergunte a alguém especial como foi seu dia"],
        ["ID": "P14", "Summary": "Olhe fotos antigas com pessoas queridas"],
        ["ID": "P15", "Summary": "Ligue para um parente mais velhinho e veja como ele está "],
        ["ID": "P16", "Summary": "Ligue para alguém que você sente saudade"],
        ["ID": "P17", "Summary": "Combine de assistir um filme com alguém "],
        ["ID": "P18", "Summary": "Cante karaokê com alguém"],
        ["ID": "P19", "Summary": "Brinque de verdade ou consequência com alguém"],
        ["ID": "P20", "Summary": "Marque uma maratona de filmes com seus amigos"],
        ["ID": "P21", "Summary": "Chame um amigo que você não vê há muito tempo para sair"]

    ]
    
    let healthChallenges = [
        ["ID": "H1", "Summary": "Ajuste a sua postura"],
        ["ID": "H2", "Summary": "Faça uma caminhada de 10 minutos"],
        ["ID": "H3", "Summary": "Se você tiver que andar de elevador hoje, escolha ir pelas escadas"],
        ["ID": "H4", "Summary": "Adicione mais vegetais às suas refeições"],
        ["ID": "H5", "Summary": "Tire 10 minutos do seu dia para organizar alguma coisa do seu ambiente. Pode ser a sua mesa do trabalho, uma gaveta no seu armário, uma prateleira da sua estante"],
        ["ID": "H6", "Summary": "Reflita sobre três coisas pelas quais você é grato"],
        ["ID": "H7", "Summary": "Encontre um momento do seu dia para fazer uma pausa e relaxar"],
        ["ID": "H8", "Summary": "Faça um alongamento"],
        ["ID": "H9", "Summary": "Fique em uma postura de yoga por dois minutos. Recomendamos a pose do cachorro olhando para baixo"],
        ["ID": "H10", "Summary": "Escreva uma carta para o seu eu do futuro e guarde num lugar seguro. Só abra daqui a 6 meses"],
        ["ID": "H11", "Summary": "Pratique o seu hobby favorito!"],
        ["ID": "H12", "Summary": "Preste atenção no quanto você reclama e tente evitar reclamar. Observe a mudança no seu humor"],
        ["ID": "H13", "Summary": "Proteja a sua pele! Use protetor solar!"],
        ["ID": "H14", "Summary": "Cante no chuveiro"],
        ["ID": "H15", "Summary": "Comemore uma pequena vitória sua hoje"],
        ["ID": "H16", "Summary": "Tente fazer uma nova receita saudável  que você está querendo experimentar"],
        ["ID": "H17", "Summary": "Beba pelo menos 5 copos d’água hoje"],
        ["ID": "H18", "Summary": "Coma frutas como lanche"],
        ["ID": "H19", "Summary": "Abra mão do chocolate por hoje"],
        ["ID": "H20", "Summary": "Se organize para dormir de modo que você tenha 8 horas de sono esta noite"],
        ["ID": "H21", "Summary": "Não mexa no celular logo antes de dormir esta noite"],
        ["ID": "H22", "Summary": "Durante as refeições de hoje, mantenha seu celular desligado e coma com calma"],
        ["ID": "H23", "Summary": "Passe hidratante no seu corpo"],
        ["ID": "H24", "Summary": "Tente uma fruta/vegetal que você nunca provou"],
        ["ID": "H25", "Summary": "Escute uma música animada e faça alguns polichinelos e agachamentos durante ela"],
        ["ID": "H26", "Summary": "Liste 3 coisas que você ama no seu corpo"],
        ["ID": "H27", "Summary": "Por hoje, fique longe dos alimentos processados"],
        ["ID": "H28", "Summary": "Marque uma consulta médica para um checkup que você não faz há muito tempo"]
    ]
}

struct Rewards {
    let mindfulnessRewards = [
        ["ID": "AH2"],
        ["ID": "AO3"],
        ["ID": "AM4"],
        ["ID": "AG3"],
        ["ID": "AN2"],
        ["ID": "AD3"],
        ["ID": "AL2"],
        ["ID": "AN1"],
        ["ID": "AB3"],
        ["ID": "AJ1"]
    ]
    
    let lovedsRewards = [
        ["ID": "AI4"],
        ["ID": "AF1"],
        ["ID": "AF4"],
        ["ID": "AB4"],
        ["ID": "AG3"],
        ["ID": "AG5"],
        ["ID": "AK5"],
        ["ID": "AN1"],
        ["ID": "AC1"],
        ["ID": "AA2"],
        ["ID": "AC11"],
        ["ID": "AM1"],
        ["ID": "AO4"],
        ["ID": "AE4"],
        ["ID": "AE5"],
        ["ID": "AN2"],
        ["ID": "AF2"],
        ["ID": "AF3"],
        ["ID": "AN3"],
        ["ID": "AH5"]
    ]
    
    let leisureRewards = [
        ["ID": "AI2"],
        ["ID": "AD1"],
        ["ID": "AN2"],
        ["ID": "AO2"],
        ["ID": "AM2"],
        ["ID": "AE1"],
        ["ID": "AM5"],
        ["ID": "AE4"],
        ["ID": "AA3"],
        ["ID": "AI6"],
        ["ID": "AA2"],
        ["ID": "AK2"],
        ["ID": "AH1"],
        ["ID": "AA2"],
        ["ID": "AB4"],
        ["ID": "AN1"],
        ["ID": "AG3"],
        ["ID": "AC4"],
        ["ID": "AC3"],
        ["ID": "AN3"],
        ["ID": "AJ6"],
        ["ID": "AC31"],
        ["ID": "AK6"],
        ["ID": "AD4"]
    ]
    
    let healthRewards = [
        ["ID": "AB1"],
        ["ID": "AG4"],
        ["ID": "AI1"],
        ["ID": "AN1"],
        ["ID": "AJ6"],
        ["ID": "AN3"],
        ["ID": "AK1"],
        ["ID": "AD1"],
        ["ID": "AG1"],
        ["ID": "AG2"],
        ["ID": "AK4"],
        ["ID": "AN2"],
        ["ID": "A01"],
        ["ID": "AM4"],
        ["ID": "AE5"],
        ["ID": "AE4"],
        ["ID": "AH4"],
        ["ID": "AA4"],
        ["ID": "AG3"]
    ]
    
}
