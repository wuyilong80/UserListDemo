# UserListDemo

This demo is use Swift programming language and MVVM architecture to implement.

Use below 3rd party:
SnapKit for make layout.
Alamofire for request GitHub UserAPI.
SDWebImage for download user avatar image.

UserListViewController to display data from UserAPI, Use UICollectionView's UICollectionViewCompositionalLayout make list UI, And is implement pagination.
Use Delegate make Controller and ViewModel connect.
UserDetailViewController to display single user's data.

Beacause of github token is been found in commit, Cause token revoked, So I try to save token in a plist, And that plist is add in .gitignore, Can fix token revoked problem, Now if you pull this repo, you must be add keys.plist file in code, or api will always failed.
