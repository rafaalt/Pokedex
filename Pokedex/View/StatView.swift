//
//  StatView.swift
//  Pokedex
//
//  Created by Rafael Torga on 11/08/24.
//

import SwiftUI

struct StatView: View {
    
    var stat: Stats
    var percent: CGFloat
    
    init(stat: Stats, percent: CGFloat) {
        self.stat = stat
        self.percent = percent
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(stat.stat.name.firstLetterUpperCased())
                    .foregroundStyle(.gray)
                Spacer()
            }
            GeometryReader { geometry in
                HStack {
                    HStack {
                        if percent>0.2 {
                            Text(String(stat.base_stat))
                                .font(.title2)
                                .bold()
                                .foregroundStyle(.white)
                            Spacer()
                        }
                        Image(systemName: returnType(type: stat.stat.name).iconName)
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal, 8)
                    .frame(width: geometry.size.width*percent, height: 50)
                    .background(returnColor(percent: percent*100))
                    .cornerRadius(8)
                    if percent <= 0.2 {
                        Text(String(stat.base_stat))
                            .font(.title2)
                            .bold()
                            .foregroundStyle(returnColor(percent: percent*100))
                    }
                    Spacer()
                }
            }
            .frame(height: 50)
        }
    }
    
    private func returnType(type: String) -> StatType {
        switch type {
        case "hp": return .hp
        case "attack": return .attack
        case "defense": return .defense
        case "special-attack": return .special_attack
        case "special-defense": return .special_defense
        case "speed": return .speed
        case "accuracy": return .accuracy
        case "evasion": return .evasion
        default: return .hp
        }
    }
    
    private func returnColor(percent: CGFloat) -> Color {
        switch percent {
        case 0...23: return .red
        case 23...47: return .orange
        case 47...68: return .yellow
        case 68...89: return .green
        default: return .blue
        }
    }
}

#Preview {
    StatView(stat: .init(base_stat: 1, effort: 1, stat: .init(name: "attack", url: "")), percent: 33)
}

enum StatType {
    case hp
    case attack
    case defense
    case special_attack
    case special_defense
    case speed
    case accuracy
    case evasion
    
    var iconName: String {
        switch self {
        case .hp:
            return "plus.app"
        case .attack:
            return "figure.fencing"
        case .defense:
            return "shield.lefthalf.filled"
        case .special_attack:
            return "figure.handball"
        case .special_defense:
            return "shield.righthalf.filled"
        case .speed:
            return "figure.run.circle"
        case .accuracy:
            return "target"
        case .evasion:
            return "figure.equestrian.sports"
        }
    }
}
