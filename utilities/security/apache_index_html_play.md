### pawned 

Set immutable attribute perm on index.html, making it non trivial to revive the website. 
We then can't copy new index.html in place of a modified one under `var/www/html`.
`rm: cannot remove ‘index.html’: Operation not permitted`

Solve it with unsetting of immutability flag. 
https://en.wikipedia.org/wiki/Chattr#In_Linux_systems_.28chattr_and_lsattr.29

