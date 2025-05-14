//
//  ModifyCardView.swift
//  CardCraft
//
//  Created by Myung Joon Kang on 2025-05-13.
//

import SwiftUI
import ErrorManager

struct ModifyCardView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var cardManager: CardManager
    @EnvironmentObject var errorManager: ErrorManager
    
    let editingCard: Card?
    let shouldShowCancelButton: Bool
    
    init(editingCard: Card?, shouldShowCancelButton: Bool = true) {
        self.editingCard = editingCard
        self.shouldShowCancelButton = shouldShowCancelButton
    }
    
    @State private var title: String = ""
    @State private var emoji: String = ""
    @State private var message: String = ""
    @State private var selectedColors: Set<CardColor> = []
    @State private var selectedSoundEffect: SoundEffect? = nil
    @State private var showEmojiError: Bool = false
    
    private var isValid: Bool {
        !title.isEmpty && !emoji.isEmpty && isEmojiValid(emoji) && !message.isEmpty && selectedColors.count >= 2
    }
    
    private var shouldDisableInteraciveDismiss: Bool {
        !title.isEmpty || !emoji.isEmpty || !message.isEmpty || !selectedColors.isEmpty || selectedSoundEffect != nil
    }
    
    private var shouldDisableSaveButtonWhenEditingExistingCard: Bool {
        guard let editingCard = self.editingCard else {
            return false
        }
        
        if editingCard.title == self.title && editingCard.emoji == self.emoji && editingCard.message == self.message && Set(editingCard.colors) == self.selectedColors && editingCard.soundEffect == self.selectedSoundEffect {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                VStack(spacing: 15) {
                    Text("Colours")
                        .customFont(size: 18, weight: .medium, design: .rounded)
                        .foregroundStyle(.secondary)
                    
                    Text("Select 2-9 colours")
                        .customFont(size: 14)
                        .foregroundStyle(.secondary)
                    
                    Text("\(selectedColors.count)/9 selected")
                        .customFont(size: 14)
                        .foregroundStyle(selectedColors.count > 1 ? Color.secondary : Color.red)
                    
                    let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 5)
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(CardColor.allCases) { color in
                            ColorButton(color: color, isSelected: selectedColors.contains(color)) {
                                withAnimation {
                                    if selectedColors.contains(color) {
                                        selectedColors.remove(color)
                                    } else if selectedColors.count < 9 {
                                        selectedColors.insert(color)
                                    }
                                }
                                
                                HapticManager.shared.impact(style: .soft)
                            }
                            .opacity((!selectedColors.contains(color) && selectedColors.count >= 9) ? 0.5 : 1.0)
                        }
                    }
                    .padding(.horizontal)
                }
                
                Divider().padding(.horizontal)
                
                VStack(spacing: 15) {
                    Text("Card Details")
                        .customFont(size: 18, weight: .medium, design: .rounded)
                        .foregroundStyle(.secondary)
                    
                    VStack(spacing: 12) {
                        TextField("Title", text: $title)
                            .customFont(size: 16, weight: .medium)
                            .padding()
                            .background(Material.ultraThin)
                            .cornerRadius(16)
                        
                        TextField("Emoji", text: $emoji)
                            .customFont(size: 16, weight: .medium)
                            .padding()
                            .background(Material.ultraThin)
                            .cornerRadius(16)
                            .onChange(of: emoji) { _, newValue in
                                showEmojiError = !emoji.isEmpty && !isEmojiValid(emoji)
                            }
                        
                        if showEmojiError {
                            Text("Please enter only emoji characters")
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }
                    .padding(.horizontal)
                }
                
                Divider().padding(.horizontal)
                
                VStack(spacing: 15) {
                    Text("Message")
                        .customFont(size: 18, weight: .medium, design: .rounded)
                        .foregroundStyle(.secondary)
                    
                    TextField("Message", text: $message)
                        .customFont(size: 16, weight: .medium)
                        .padding()
                        .background(Material.ultraThin)
                        .cornerRadius(16)
                }
                .padding(.horizontal)
                
                Divider().padding(.horizontal)
                
                VStack(spacing: 15) {
                    Text("Sound Effect")
                        .customFont(size: 18, weight: .medium, design: .rounded)
                        .foregroundStyle(.secondary)
                    
                    Picker("Sound Effect", selection: $selectedSoundEffect) {
                        Text("None")
                            .tag(Optional<SoundEffect>.none)
                        
                        ForEach(SoundEffect.allCases) { effect in
                            Text(effect.rawValue)
                                .tag(Optional<SoundEffect>.some(effect))
                        }
                    }
                    .pickerStyle(.menu)
                    .alignView(to: .leading)
                    .padding()
                    .background(Material.ultraThin)
                    .cornerRadius(16)
                    
                    if let selectedEffect = selectedSoundEffect {
                        Button {
                            do {
                                try SoundEffectManager.shared.playSoundEffect(selectedEffect)
                            } catch {
                                errorManager.showError(error as? SoundEffectManagerError ?? .unknownError)
                            }
                        } label: {
                            Label("Preview Sound", systemImage: "play.circle.fill")
                                .customFont(size: 16, weight: .medium)
                        }
                        .scaleButtonStyle()
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .prioritiseScaleButtonStyle()
        .scrollDismissesKeyboard(.immediately)
        .interactiveDismissDisabled(shouldDisableInteraciveDismiss)
        .navigationTitle(self.editingCard == nil ? "Create Card" : "Edit Card")
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom, spacing: 20) {
            VStack {
                Text("Preview")
                    .customFont(size: 18, weight: .medium, design: .rounded)
                    .foregroundStyle(.secondary)
                
                if self.selectedColors.count >= 2 {
                    CardPreview(
                        emoji: $emoji,
                        title: $title,
                        message: $message,
                        colors: Array(selectedColors).map { $0.getColor() }
                    )
                    .cornerRadius(20, corners: .allCorners)
                    .transition(.blurReplace.combined(with: .offset(y: 10)))
                } else {
                    ContentUnavailableView("Select More Colours", systemImage: "paintpalette", description: Text("Please select at least 2 colours to preview your card"))
                        .transition(.blurReplace.combined(with: .offset(y: 10)))
                }
            }
            .frame(maxHeight: 235)
            .padding()
            .padding(.bottom, 15)
            .background(Material.ultraThin)
            .cornerRadius(20, corners: [.topLeft, .topRight])
        }
        .ignoresSafeArea(.container, edges: .bottom)
        .toolbar {
            if self.shouldShowCancelButton {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                        reset()
                    }.fontWeight(.medium)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    saveChanges()
                    self.viewModel.hideCardDetailView()
                    reset()
                    HapticManager.shared.impact(style: .soft)
                }
                .fontWeight(.semibold)
                .disabled(!isValid || shouldDisableSaveButtonWhenEditingExistingCard)
            }
        }
        .task {
            if let editingCard = editingCard {
                withAnimation {
                    self.title = editingCard.title
                    self.emoji = editingCard.emoji
                    self.message = editingCard.message
                    self.selectedColors = Set(editingCard.colors)
                    self.selectedSoundEffect = editingCard.soundEffect
                }
            }
        }
        .onDisappear(perform: reset)
    }
    
    private func isEmojiValid(_ text: String) -> Bool {
        guard !text.isEmpty else { return false }
        return text.unicodeScalars.allSatisfy { scalar in
            scalar.properties.isEmoji
        }
    }
    
    private func saveChanges() {
        let cardToSave = Card(title: title, emoji: emoji, colors: Array(selectedColors), message: message, soundEffect: selectedSoundEffect, creationDate: Date.now)
        
        do {
            if let editingCard = self.editingCard {
                try self.cardManager.deleteCard(id: editingCard.id)
            }
            
            self.cardManager.addCard(cardToSave)
            try self.cardManager.saveCards()
        } catch {
            self.errorManager.showError(error as? CardManagerError ?? .unknownError)
        }
    }
    
    private func reset() {
        withAnimation {
            self.title.removeAll()
            self.emoji.removeAll()
            self.message.removeAll()
            self.selectedColors.removeAll()
            self.selectedSoundEffect = nil
        }
    }
}

fileprivate struct ColorButton: View {
    let color: CardColor
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Circle()
                .fill(color.getColor().gradient)
                .frame(width: 50, height: 50)
                .overlay {
                    if isSelected {
                        Image(systemName: "checkmark")
                            .foregroundColor(color.getTextColor())
                    }
                }
        }.scaleButtonStyle(scaleAmount: 0.97)
    }
}

#Preview {
    NavigationStack {
        ModifyCardView(editingCard: nil)
            .environmentObject(CardManager())
            .environmentObject(ViewModel())
            .environmentObject(ErrorManager())
    }
}
