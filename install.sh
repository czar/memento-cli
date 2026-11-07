#!/bin/bash
# memento-cli & mori-kernel Integrated Installer (Optimized)
# Includes: Quotes from Tsongkhapa's LamRim (Public Domain Content)

# --- Configuration ---
BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"
export PATH="$BIN_DIR:$PATH"

echo "--- 💀 Memento Mori Integration Setup ---"

# 1. Collect User Data for the Kernel
read -p "Enter your birthdate (YYYY-MM-DD): " BIRTHDATE
if [[ ! $BIRTHDATE =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
    echo "❌ Invalid date format. Please use YYYY-MM-DD."
    exit 1
fi

read -p "Enter sex (m/f) [optional]: " SEX
read -p "Enter expected lifetime in years [optional, default 81]: " LIFETIME
LIFETIME=${LIFETIME:-81}

# 2. Install the Kernel (mementomori)
echo "📦 Installing mori-kernel to $BIN_DIR/mementomori..."

# Check if source file exists before copying
if [[ -f "mementomori" ]]; then
    cp mementomori "$BIN_DIR/"
    chmod +x "$BIN_DIR/mementomori"  # Added as requested
    echo "✅ Kernel binary installed and made executable."
else
    echo "❌ Error: Source file 'mementomori' not found in current directory."
    exit 1
fi

# 3. Create the Wisdom Data Store (LamRim)
cat << 'EOF' > ~/.lamrim_death.txt
# SOURCE: LamRim (Stages of the Path to Enlightenment)
# AUTHOR: Tsongkhapa (14th-15th Century)
# TRANSLATION: Various Translations
# PURPOSE: High-frequency wisdom injection for terminal-based workflows.
#### ⏳ Layer A: The Temporal Compression Filter (The Urgency Protocol)
* "What could be more dangerous than to sleep as though at ease while subject to the Lord of Death, Ruler of the three worlds, himself without a master?" #Urgency
* "The thought that you will not die is the source of all deterioration, and the remedy for this is mindfulness of death, the source of all that is excellent." #Urgency
* "This life is constantly lost day and night without a pause, and there is nothing which can extend it. Why should death not come to someone like me?" #Urgency
* "The Lord of Death... descends suddenly. So do not wait, saying, 'I'll do it tomorrow.' Practice the sublime teaching with urgency." #Urgency
* "It is not good for people to say, 'I'll put it off until tomorrow and do this today.' A tomorrow when you are gone will undoubtedly come." #Urgency
* "As long as that great unforgiving warrior has not fired the unstoppable arrow from which there is no escape, strive for your own welfare." #Urgency
* "The idea of death is that hateful enemies constantly surround this life, ruining it at every moment. Nothing exists that extends your life." #Urgency
* "You do not know on which day the enemy will come; you must be cautious every day." #Urgency
#### 💎 Layer B: The Attachment Filter (The Vanitas Protocol)
* "I will have to depart, leaving everything. But, not knowing this, I committed various sins for the sake of friends and foes." #Attachment
* "Among all ideas, the idea of impermanence and death is supreme because with it you eliminate all the attachment, ignorance, and pride of the three realms." #Attachment
* "For those who have not practiced the path at all, the fear of death manifests itself as the worry that they will be separate from your relatives... This fear is caused by their strong attachment." #Attachment
* "When the past karma that caused this life is spent, and you are connected with new karma and led by the Lord of Death, everyone turns back. Except for your virtue and sin, nothing will follow you." #Attachment
* "Eventually not even one being or thing will follow after you. In brief, if you lack even a name, what need is there to speak about anything else?" #Attachment
* "Those who are tortured by bad karma waste their wonderful leisure and opportunity... in order to acquire some trifling thing which is not so rare and which even animals may attain." #Attachment
* "Exclude all the appearances of this life such as intimates, relatives, and possessions. Until [lack of attachment] arises in your mind, the paths of all the teachings remain blocked." #Attachment
#### 🦴 Layer C: The Biological Reality Filter (The Decay Protocol)
* "Somewhere to live that is unharmed by death—such a place does not exist. It does not exist in space, it does not exist in the sea, nor if you stay in the midst of mountains." #Decay
* "Decay comes and destroys all that is excellent." #Decay
* "The rippling flow of the water was good for meditation on impermanence." #Decay
* "Half of the one-hundred-year life span is covered by sleep. Ten years are childhood. Twenty years are old age... Many hundreds of different physical illnesses also consume your time." #Decay
* "You dwell among the causes of death like a butter lamp standing in a strong breeze." #Decay
* "Life is more impermanent than a water bubble battered by the winds of many perils. Thus, that you can inhale after exhaling, or awaken from sleep—these things are fantastic." #Decay
* "The causes of death are many; those of staying alive, few. These too become causes of death." #Decay
* "If not even ash will remain when the physical world... is burned up by seven blazing suns, what need is there to mention humans, who are so very frail?" #Decay
* "While this borrowed body is still healthy, without sickness or deterioration, take full advantage of it, acting in order to end your fear of sickness, death, and deterioration." #Decay
* "Meditate again and again until you have turned your mind away from the activities of this life, which are like adorning yourself while being led to the execution ground." #Decay
EOF

# 4. Detect Shell
if [[ "$SHELL" == *'zsh'* ]]; then
    CONF="$HOME/.zshrc"
elif [[ "$SHELL" == *'bash'* ]]; then
    CONF="$HOME/.bashrc"
else
    echo "❌ Unsupported shell: $SHELL"
    exit 1
fi

# 5. Inject Logic (Wisdom + Kernel Stats)
echo "💉 Injecting into $CONF..."

# A. Wisdom Injection
INJECTION_WISDOM='QUOTE=$(sed -n '\''s/^\* "\([^"]*\)" #.*/\1/p'\'' ~/.lamrim_death.txt | shuf -n 1); [ -n "$QUOTE" ] && echo -e "\n\e[1;31m[Memento Mori]\e[0m $QUOTE"'

# B. Kernel Stats Injection
# INJECTION_STATS="$BIN_DIR/mementomori -b $BIRTHDATE -s ${SEX:-m} -l $LIFETIME -v"
INJECTION_STATS="$BIN_DIR/mementomori -b $BIRTHDATE -s ${SEX:-m} -v"

# Apply injections with duplicate protection
if ! grep -q "LamRim Wisdom Injector" "$CONF"; then
    echo "" >> "$CONF"
    echo "# LamRim Wisdom Injector" >> "$CONF"
    echo "$INJECTION_WISDOM" >> "$CONF"
else
    echo "⚠️ Wisdom already installed."
fi

if ! grep -q "Mori-Kernel Stats Injector" "$CONF"; then
    echo "" >> "$CONF"
    echo "# Mori-Kernel Stats Injector" >> "$CONF"
    echo "$INJECTION_STATS" >> "$CONF"
    echo "✅ Kernel stats injection added."
else
    echo "⚠️ Kernel stats already installed."
fi

echo "🚀 Integration complete. Restart your terminal or run 'source $CONF'."
