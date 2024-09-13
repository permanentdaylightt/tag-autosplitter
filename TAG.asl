state("Tag", "IGF Professional 2008") {
    int NextLevelNumber : 0x16C088, 0x40;
    int StartGame : 0x16C094, 0x14;
    byte Loading : 0x16C05C, 0x5C;
}

state("Tag", "v1.1") {
    int NextLevelNumber : 0x16D0E8, 0x40;
    int StartGame : 0x16D0F4, 0x14;
    byte Loading : 0x16D0BC, 0x5C;
}

init {
    int Size = modules.First().ModuleMemorySize;
    switch (Size) {
        case 1511424:
            version = "IGF Professional 2008";
            print("TAG Autosplitter: Detected version IGF Professional 2008");
            break;
        case 1515520:
            version = "v1.1";
            print("TAG Autosplitter: Detected version 1.1");
            break;
        default:
            print("TAG Autosplitter: Unknown module size " + Size.ToString());
            MessageBox.Show(
                timer.Form,
                "TAG Autosplitter Error:\n\n" +
                "Game version not recognized.\n" +
                "Please report bugs at TAG speedrunning Discord.\n\n" +
                "Module size: " + Size.ToString(),
                "TAG Autosplitter Error",
                MessageBoxButtons.OK,
                MessageBoxIcon.Error
            );
            break;
    }
}

reset {
    return current.StartGame == 0;
}

start {
    return old.StartGame == 0 && current.StartGame != 0;
}

split {
    return current.NextLevelNumber != 0 && old.NextLevelNumber != current.NextLevelNumber;
}

isLoading {
    return current.Loading == 1;
}
