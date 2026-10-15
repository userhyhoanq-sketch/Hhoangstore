import SwiftUI

@main
struct FFMenuDemoApp: App {
    var body: some Scene {
        WindowGroup { ContentView() }
    }
}

struct ContentView: View {
    @State private var tab = 0
    @State private var aimbot = false
    @State private var esp = true
    @State private var name = true
    @State private var line = false
    @State private var box = true
    @State private var skeleton = false
    @State private var ignoreBots = true
    @State private var fov: Double = 120
    @State private var speed: Double = 50

    private let purple = Color(red: 0.72, green: 0.30, blue: 1.0)

    var body: some View {
        ZStack {
            Color(red: 0.035, green: 0.035, blue: 0.055).ignoresSafeArea()
            VStack(spacing: 16) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("FOXES").font(.system(size: 27, weight: .black, design: .rounded)).foregroundStyle(.white)
                        Text("UI DEMO  •  iOS").font(.caption2.weight(.bold)).tracking(2).foregroundStyle(purple)
                    }
                    Spacer()
                    Text("V3").font(.headline.bold()).foregroundStyle(purple)
                        .padding(.horizontal, 14).padding(.vertical, 8)
                        .background(purple.opacity(0.13)).clipShape(Capsule())
                }
                HStack(spacing: 8) {
                    tabButton("AIM", index: 0)
                    tabButton("ESP", index: 1)
                    tabButton("SETTINGS", index: 2)
                }
                ScrollView {
                    VStack(spacing: 12) {
                        if tab == 0 {
                            section("AIM ASSIST — DEMO") {
                                toggleRow("Aimbot (UI only)", detail: "Does not control the game", value: $aimbot)
                                toggleRow("Ignore bots", detail: nil, value: $ignoreBots)
                                sliderRow("FOV Radius", value: $fov, range: 10...300, suffix: "")
                                sliderRow("Aim Speed", value: $speed, range: 1...100, suffix: "%")
                                choiceRow("Aim position", choices: ["Head", "Neck", "Chest"])
                            }
                        } else if tab == 1 {
                            section("ESP — VISUAL DEMO") {
                                toggleRow("ESP overlay (UI only)", detail: "No game overlay is connected", value: $esp)
                                toggleRow("Player nickname", detail: nil, value: $name)
                                toggleRow("Tracer lines", detail: nil, value: $line)
                                toggleRow("2D box", detail: nil, value: $box)
                                toggleRow("Skeleton", detail: nil, value: $skeleton)
                            }
                        } else {
                            section("SETTINGS") {
                                toggleRow("Anti-ban status (demo)", detail: "Informational only; no protection", value: .constant(false))
                                HStack {
                                    Text("Theme").foregroundStyle(.white)
                                    Spacer()
                                    Text("Neon Purple").foregroundStyle(purple).fontWeight(.semibold)
                                }.padding(.vertical, 7)
                                Text("This app is a standalone UI mockup. It does not modify Free Fire, provide cheats, or prevent bans.")
                                    .font(.footnote).foregroundStyle(.white.opacity(0.55))
                            }
                        }
                    }.padding(.bottom, 12)
                }
                Text("STANDALONE MOCKUP • NOT CONNECTED TO FREE FIRE")
                    .font(.system(size: 9, weight: .bold)).tracking(1)
                    .foregroundStyle(.white.opacity(0.35))
            }.padding(18)
        }.preferredColorScheme(.dark)
    }

    private func tabButton(_ title: String, index: Int) -> some View {
        Button { tab = index } label: {
            Text(title).font(.system(size: 11, weight: .heavy)).tracking(1)
                .frame(maxWidth: .infinity).padding(.vertical, 13)
                .foregroundStyle(tab == index ? .black : .white.opacity(0.65))
                .background(tab == index ? purple : Color.white.opacity(0.06))
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }

    private func section<Content: View>(_ title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 13) {
            Text(title).font(.caption.weight(.heavy)).tracking(1.5).foregroundStyle(purple)
            content()
        }.padding(16).frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white.opacity(0.045))
            .overlay(RoundedRectangle(cornerRadius: 17).stroke(purple.opacity(0.25), lineWidth: 1))
            .clipShape(RoundedRectangle(cornerRadius: 17))
    }

    private func toggleRow(_ title: String, detail: String?, value: Binding<Bool>) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                Text(title).font(.subheadline.weight(.semibold)).foregroundStyle(.white)
                if let detail { Text(detail).font(.caption2).foregroundStyle(.white.opacity(0.45)) }
            }
            Spacer()
            Toggle("", isOn: value).labelsHidden().tint(purple).scaleEffect(0.85, anchor: .trailing)
        }.padding(.vertical, 3)
    }

    private func sliderRow(_ title: String, value: Binding<Double>, range: ClosedRange<Double>, suffix: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title).foregroundStyle(.white).font(.subheadline.weight(.semibold))
                Spacer()
                Text("\(Int(value.wrappedValue))\(suffix)").foregroundStyle(purple).font(.subheadline.bold())
            }
            Slider(value: value, in: range).tint(purple)
        }.padding(.vertical, 3)
    }

    private func choiceRow(_ title: String, choices: [String]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title).foregroundStyle(.white).font(.subheadline.weight(.semibold))
            HStack(spacing: 8) {
                ForEach(choices, id: \.self) { choice in
                    Text(choice).font(.caption.bold()).frame(maxWidth: .infinity).padding(.vertical, 10)
                        .background(choice == "Head" ? purple.opacity(0.28) : Color.white.opacity(0.06))
                        .foregroundStyle(.white).clipShape(RoundedRectangle(cornerRadius: 9))
                }
            }
        }
    }
}
