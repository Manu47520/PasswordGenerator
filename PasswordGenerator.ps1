$Host.UI.RawUI.WindowTitle = "Password Generator - Emmanuel MARCEROU"

function Generate-RandomPassword {
    param (
        [int]$length
    )
    
    $upperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    $lowerCase = "abcdefghijklmnopqrstuvwxyz"
    $numbers = "0123456789"
    $symbols = "!@#$%&*()-_=+.?/"

    $allChars = $upperCase + $lowerCase + $numbers + $symbols

    $password = (Get-Random -InputObject $upperCase -Count 1) +
                (Get-Random -InputObject $lowerCase -Count 1) +
                (Get-Random -InputObject $numbers -Count 1) +
                (Get-Random -InputObject $symbols -Count 1)

    while ($password.Length -lt $length) {
        $password += Get-Random -InputObject $allChars -Count 1
    }

    $passwordArray = $password.ToCharArray() | Sort-Object {Get-Random}
    
    return -join $passwordArray[0..($length-1)]
}

[int]$numberOfPasswords = Read-Host "Entrez le nombre de mots de passe à générer"

[int]$passwordLength = Read-Host "Entrez la longueur des mots de passe à générer"

Write-Host ""

for ($i = 1; $i -le $numberOfPasswords; $i++) {
    $password = Generate-RandomPassword -length $passwordLength
    Write-Host "Mot de passe $i : $password"
}

Write-Host ""
Write-Host "Appuyez sur une touche pour quitter..."
[System.Console]::ReadKey($true)
