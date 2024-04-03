# Made By Taylor Christian Newsome
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Net.Http

# Function to download the image
function Download-Image {
    param (
        [string]$url,
        [string]$path
    )
    $client = New-Object System.Net.WebClient
    $client.DownloadFile($url, $path)
}

# Create a temporary file path for the image
$imagePath = [System.IO.Path]::GetTempFileName() + ".gif"
Download-Image "https://media.tenor.com/NkrdlIBG3psAAAAi/would-you-like-help-clippy.gif" $imagePath

$form = New-Object System.Windows.Forms.Form
$form.Text = 'PowerShell Clippy'
$form.Size = New-Object System.Drawing.Size(500, 400) # Adjusted size to accommodate the image
$form.StartPosition = 'CenterScreen'
$form.FormBorderStyle = 'None'
$form.BackColor = 'White'
$form.TransparencyKey = 'White'
$form.Opacity = 0.95 # Adjust for desired transparency level

# Close Button ("X")
$closeButton = New-Object System.Windows.Forms.Button
$closeButton.Text = 'X'
$closeButton.Location = New-Object System.Drawing.Point($form.Width - 40, 10) # Adjust as necessary
$closeButton.Size = New-Object System.Drawing.Size(30, 30)
$closeButton.BackColor = 'Red'
$closeButton.ForeColor = 'White'
$closeButton.FlatStyle = 'Flat'
$closeButton.add_Click({
    $form.Close()
})

# PictureBox to display the GIF
$pictureBox = New-Object System.Windows.Forms.PictureBox
$pictureBox.Size = New-Object System.Drawing.Size(480, 320) # Adjust size as needed
$pictureBox.Location = New-Object System.Drawing.Point(10, 50) # Adjust location as needed
$pictureBox.SizeMode = 'StretchImage'
$pictureBox.Image = [System.Drawing.Image]::Fromfile($imagePath)
$pictureBox.BackColor = [System.Drawing.Color]::Transparent

$form.Controls.Add($pictureBox)
$form.Controls.Add($closeButton)

$form.Add_Shown({$form.Activate()})
$form.ShowDialog()

# Cleanup
Remove-Item $imagePath -ErrorAction SilentlyContinue
