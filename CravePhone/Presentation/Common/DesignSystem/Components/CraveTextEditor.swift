//
//  CraveTextEditor.swift
//  CravePhone
//
//  SINGLE RESPONSIBILITY:
//    - Provides text input with placeholders, speech mic icon, and character limit.
//
//  ARCHITECTURE (Uncle Bob / SOLID):
//    - No duplication of onChangeBackport. We rely on the version in View+Extensions.swift.
//
//  “DESIGNED FOR STEVE JOBS”:
//    - Minimal friction, fluid animations.
//
//  LAST UPDATED: <today’s date>
//

import SwiftUI

struct CraveTextEditor: View {
    
    // MARK: - Bound & Injected
    @Binding var text: String
    let isRecordingSpeech: Bool
    let onMicTap: () -> Void
    
    let characterLimit: Int
    let placeholderLines: [PlaceholderLine]
    
    // MARK: - Local State
    @State private var editorHeight: CGFloat = 120
    @FocusState private var isFocused: Bool
    
    enum PlaceholderLine: Equatable {
        case plain(String)
        case gradient(String)
    }
    
    init(
        text: Binding<String>,
        isRecordingSpeech: Bool = false,
        onMicTap: @escaping () -> Void = {},
        characterLimit: Int = 300,
        placeholderLines: [PlaceholderLine] = []
    ) {
        self._text = text
        self.isRecordingSpeech = isRecordingSpeech
        self.onMicTap = onMicTap
        self.characterLimit = characterLimit
        self.placeholderLines = placeholderLines
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            // 1) Placeholder
            if text.isEmpty, !placeholderLines.isEmpty {
                placeholderContent
                    .padding(.top, 12)
                    .padding(.horizontal, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .opacity(isFocused ? 0.4 : 0.7)
                    .animation(.easeOut(duration: 0.2), value: isFocused)
                    .onTapGesture { isFocused = true }
            }
            
            // 2) Main TextEditor
            textEditorView
                .focused($isFocused)
                .frame(height: max(editorHeight, 120))
                .background(Color.black.opacity(0.3))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(
                            isFocused
                                ? CraveTheme.Colors.accent.opacity(0.5)
                                : Color.white.opacity(0.3),
                            lineWidth: 1
                        )
                        .animation(.easeInOut(duration: 0.2), value: isFocused)
                )
            
            // 3) Mic Button
            Button {
                CraveHaptics.shared.lightImpact()
                onMicTap()
            } label: {
                Image(systemName: isRecordingSpeech ? "waveform.circle.fill" : "mic.fill")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(
                        isRecordingSpeech
                            ? CraveTheme.Colors.accent
                            : Color.white.opacity(0.8)
                    )
                    .padding(8)
                    .background(
                        Circle()
                            .fill(
                                isRecordingSpeech
                                    ? Color.white.opacity(0.2)
                                    : Color.black.opacity(0.4)
                            )
                            .animation(.easeOut(duration: 0.2), value: isRecordingSpeech)
                    )
                    .overlay(
                        Circle()
                            .stroke(
                                isRecordingSpeech ? CraveTheme.Colors.accent : .clear,
                                lineWidth: 1.5
                            )
                    )
                    .scaleEffect(isRecordingSpeech ? 1.1 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isRecordingSpeech)
            }
            .padding(8)
            .accessibilityLabel(isRecordingSpeech ? "Stop recording" : "Start voice input")
        }
    }
    
    // MARK: - Placeholder
    private var placeholderContent: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(placeholderLines.indices, id: \.self) { idx in
                switch placeholderLines[idx] {
                case .plain(let line):
                    Text(line)
                        .font(CraveTheme.Typography.body.weight(.medium))
                        .foregroundColor(CraveTheme.Colors.placeholderSecondary)
                case .gradient(let line):
                    GradientText(
                        text: line,
                        font: CraveTheme.Typography.largestCraving,
                        gradient: CraveTheme.Colors.cravingOrangeGradient
                    )
                }
            }
        }
    }
    
    // MARK: - Logic
    private func calculateEditorHeight() {
        let linesCount = text.count / 35 + 1
        let newHeight = min(max(120, CGFloat(linesCount) * 20), 300)
        if editorHeight != newHeight {
            withAnimation(.easeOut(duration: 0.2)) {
                editorHeight = newHeight
            }
        }
    }
}

extension CraveTextEditor {
    var textEditorView: some View {
        let base = TextEditor(text: $text)
            .font(CraveTheme.Typography.body)
            .foregroundColor(CraveTheme.Colors.primaryText)
            .modifier(ScrollBackgroundClearModifier())
            .padding(.trailing, 44) // space for mic
        
        // Use onChangeBackport from View+Extensions
        return AnyView(
            base.onChangeBackport(of: text, initial: false) { oldVal, newVal in
                // limit text
                if characterLimit > 0, newVal.count > characterLimit {
                    text = String(newVal.prefix(characterLimit))
                    CraveHaptics.shared.notification(type: .warning)
                }
                calculateEditorHeight()
            }
        )
    }
}

// Clears background in older iOS or uses .scrollContentBackground(.hidden)
struct ScrollBackgroundClearModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            return AnyView(content.scrollContentBackground(.hidden))
        } else {
            return AnyView(
                content
                    .onAppear { UITextView.appearance().backgroundColor = .clear }
                    .onDisappear { UITextView.appearance().backgroundColor = nil }
            )
        }
    }
}
