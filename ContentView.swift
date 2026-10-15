import SwiftUI

struct ContentView: View {
    @State private var page = 0
    @State private var enabled: [String: Bool] = [
        "Aimbot": false, "Draw FOV Circle": true, "Ignore Bots": false,
        "Ignore Knocked": true, "Aim Silent": false,
        "Tracelines": true, "2D Box": true, "Health Bar": true,
        "Player Nickname": false, "Distance Meter": false,
        "Live Player Counter": true, "ESP Skeleton": false,
        "Anti-Ban (demo)": false
    ]
    @State private var fov = 33.0
    @State private var speed = 2000.0
    @State private var distance = 230.0
    @State private var aimPosition = "Neck"
    private let cyan = Color(red: 0.30, green: 0.73, blue: 0.78)
    private let ink = Color(red: 0.07, green: 0.07, blue: 0.10)

    var body: some View {
        ZStack {
            LinearGradient(colors: [ink, Color(red: 0.16, green: 0.08, blue: 0.22), ink],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack(spacing: 0) {
                HStack(spacing: 10) {
                    Image(systemName: "gearshape.fill").foregroundStyle(cyan).font(.title2)
                    Text("Foxes ext V3").font(.title2.bold()).foregroundStyle(cyan)
                    Spacer()
                    Button { } label: {
                        Image(systemName: "xmark").font(.title3.bold()).foregroundStyle(.white)
                    }
                }
                .padding(18)
                .background(Color.white.opacity(0.07))

                HStack(spacing: 10) {
                    tab("AIMBOT", index: 0)
                    tab("ESP", index: 1)
                    tab("SETTINGS", index: 2)
                }
                .padding(12)

                ScrollView {
                    VStack(spacing: 0) {
                        if page == 0 {
                            toggleRow("Aimbot")
                            toggleRow("Draw FOV Circle")
                            toggleRow("Ignore Bots")
                            toggleRow("Ignore Knocked")
                            toggleRow("Aim Silent")
                            sliderRow("FOV Radius", value: $fov, range: 1...180, suffix: " px")
                            sliderRow("Aim Speed", value: $speed, range: 0...2000, suffix: "")
                            sliderRow("Aim Distance", value: $distance, range: 1...500, suffix: " m")
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Aim Position").font(.headline)
                                Picker("Aim Position", selection: $aimPosition) {
                                    ForEach(["Head", "Neck", "Chest", "U.Head"], id: \.self) {
                                        Text($0).tag($0)
                                    }
                                }.pickerStyle(.segmented)
                            }.padding(16)
                        } else if page == 1 {
                            toggleRow("Tracelines")
                            toggleRow("2D Box")
                            toggleRow("Health Bar")
                            toggleRow("Player Nickname")
                            toggleRow("Distance Meter")
                            toggleRow("Live Player Counter")
                            toggleRow("ESP Skeleton")
                            Text("ESP ở đây chỉ là mục giao diện minh họa.")
                                .font(.footnote).foregroundStyle(.white.opacity(0.6))
                                .frame(maxWidth: .infinity, alignment: .leading).padding(16)
                        } else {
                            toggleRow("Anti-Ban (demo)")
                            Text("Mục minh họa בלבד — không có khả năng chống ban thực tế.")
                                .font(.footnote).foregroundStyle(.white.opacity(0.65))
                                .frame(maxWidth: .infinity, alignment: .leading).padding(16)
                        }
                    }
                }
                Text("UI DEMO • Không tác động vào game")
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(.white.opacity(0.45))
                    .padding(.vertical, 12)
            }
            .background(Color(red: 0.10, green: 0.10, blue: 0.13).opacity(0.97))
            .clipShape(RoundedRectangle(cornerRadius: 22))
            .overlay(RoundedRectangle(cornerRadius: 22).stroke(cyan.opacity(0.35), lineWidth: 1))
            .padding()
        }
        .preferredColorScheme(.dark)
    }

    private func tab(_ title: String, index: Int) -> some View {
        Button { page = index } label: {
            Text(title).font(.caption.bold())
                .frame(maxWidth: .infinity).padding(.vertical, 11)
                .background(page == index ? cyan : Color.white.opacity(0.07))
                .foregroundStyle(page == index ? ink : .white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }

    private func toggleRow(_ title: String) -> some View {
        Toggle(isOn: Binding(
            get: { enabled[title, default: false] },
            set: { enabled[title] = $0 }
        )) {
            Text(title).font(.system(size: 16, weight: .semibold)).foregroundStyle(.white)
        }
        .tint(cyan)
        .padding(.horizontal, 16).padding(.vertical, 12)
        .overlay(alignment: .bottom) { Rectangle().fill(.white.opacity(0.08)).frame(height: 1) }
    }

    private func sliderRow(_ title: String, value: Binding<Double>,
                           range: ClosedRange<Double>, suffix: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(title) · \(Int(value.wrappedValue))\(suffix)")
                .font(.system(size: 16, weight: .semibold)).foregroundStyle(.white)
            Slider(value: value, in: range).tint(cyan)
        }
        .padding(.horizontal, 16).padding(.vertical, 12)
        .overlay(alignment: .bottom) { Rectangle().fill(.white.opacity(0.08)).frame(height: 1) }
    }
}

#Preview {
    ContentView()
}
