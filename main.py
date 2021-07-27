import os

# pve
RoguePoisons = ["MindNumbingPoison", "Instant Poison"]
Actions = ["actions.precombat=", "actions=", "actions+=/", "actions.build=", "actions.build+=/", "actions.cds=",
           "actions.cds+=/", "actions.finish=", "actions.finish+=/", "actions.stealth=","actions.stealth+=/"]
KeyWords = [",", ",if=", "if=", "if=!", "!", "&", "|", ">=", ">", "<=", "<"]
blackListed = ["#"]
Conditionals = {"energy.deficit": " Player:EnergyDeficit() ", "energy.regen": " Player:EnergyRegen() ",
                "combo_points.deficit": " Player:ComboPointsDeficit() ",
                "buff.opportunity.up": " Unit('player'):HasBuffs(A.Opportunity.ID) ~= 0 ",
                "!dot.serrated_bone_spike_dot.ticking": " Unit(unitID):HasDeBuffs(A.SerratedBoneSpike.ID) == 0",
                "energy.time_to_max": " Player:EnergyTimeToMax() ",
                "fight_remains": " Unit(unitID):TimeToDie() "}


def refactorWord(word):
    result = ""
    allWords = word.split("_")
    for word in allWords:
        result += word.capitalize()
    result = result.replace("\n", "")
    return result


def createFile(name):
    file = open("Action/" + name, "x")
    file.truncate(0)
    file.close()

def writeToFile(name, body):
    file = open("Action/" + name, "a")
    file.write(body + "\n")


lastAction = ""
lastAction2 = ""
def processData(line, fileName):
    global lastAction
    global lastAction2
    fileName = fileName.replace(".txt", ".lua")
    buildQuery = ""
    if not os.path.exists("Action/" + fileName):
        createFile(fileName)
    for AllActions in Actions:
        SpellName = ""
        OtherConditions = ""
        if line.startswith(blackListed[0]):
            return
        if line.find("variable.finish_condition") != -1:
            return
        if line.find(AllActions) == 0:
            everythingElseAfterAction = line.split(AllActions, 1)[1]
            if lastAction != AllActions:
                lastAction = lastAction.replace("=", "+=/")
                if lastAction != AllActions:
                    if lastAction2 == "":
                        lastAction2 = lastAction
                    lastAction = AllActions
                    filteredAction = AllActions.replace("+=/", "", 1)
                    filteredAction = filteredAction.replace("actions.", "", 1)
                    filteredAction = filteredAction.replace("=", "", 1)
                    if lastAction2 != AllActions and lastAction2 != "":
                        buildQuery += "end\n\n"
                        lastAction2 = ""
                    buildQuery += "local function " + filteredAction + "() then\n"
            hasKeyword = False
            for i, keyword in enumerate(KeyWords):
                count = len(KeyWords) - 1
                try:
                    everythingElseAfterAction.split(keyword, 1)[1]
                    hasKeyword = True
                    if everythingElseAfterAction.find(keyword) != -1:
                        SpellName = everythingElseAfterAction.split(keyword, 1)[0]
                        SpellName = refactorWord(SpellName)
                        try:
                            for condition in Conditionals:
                                if everythingElseAfterAction.find(condition) != -1:
                                    inBetween = everythingElseAfterAction.split(condition, 1)[1]
                                    beforeFirstSplit = everythingElseAfterAction.split(condition, 1)[0]
                                    #need to add all of what happens before [1] aka [0]
                                    inBetweenParser = ""
                                    inBetweenParser2 = ""
                                    for conditional2 in Conditionals:
                                        if beforeFirstSplit.find(conditional2) != -1:
                                            afterConditional = beforeFirstSplit.split(conditional2, 1)[1]
                                            inBetweenParser2 = Conditionals[conditional2] + afterConditional
                                        if inBetween.find(conditional2) != -1:
                                            beforeConditional = inBetween.split(conditional2, 1)[0]
                                            afterConditional = inBetween.split(conditional2, 1)[1]
                                            inBetweenParser = beforeConditional + Conditionals[conditional2] + afterConditional

                                    inBetweenParser = inBetweenParser.replace("\n", "")
                                    inBetweenParser2 = inBetweenParser2.replace("\n", "")
                                    OtherConditions += inBetweenParser2 + Conditionals[condition] + inBetweenParser + " then\n\t\treturn A." + SpellName + ":Show(icon)\n\tend"
                                    break
                        except IndexError:
                            pass
                        break
                    # more logic if there is conditional shit behind it
                except IndexError:
                    if i >= count and hasKeyword is False:
                    # need to check if count is at final and if a keyword matched for false positives
                        SpellName = everythingElseAfterAction
                        SpellName = refactorWord(SpellName)
                        OtherConditions = " then\n\t\treturn A." + SpellName + ":Show(icon)\n\tend\n"
            OtherConditions = OtherConditions.replace("|", "or")
            OtherConditions = OtherConditions.replace("&", "and")
            if OtherConditions != " then\n\t\treturn A." + SpellName + ":Show(icon)\n\tend\n":
                buildQuery += "\tif A." + SpellName + ":IsReady(unitID, true) and" + OtherConditions
            else:
                buildQuery += "\tif A." + SpellName + ":IsReady(unitID, true)" + OtherConditions
    if buildQuery != "":
        writeToFile(fileName, buildQuery)


def main():
    simcDir = "simc/"
    for filename in os.listdir(simcDir):
        if filename.endswith(".txt"):
            file = open("simc/" + filename, "r")
            reader = file.readlines()
            for line in reader:
                processData(line, filename)
            writeFile = filename.replace(".txt", ".lua")
            writeToFile(writeFile, "end")


main()
