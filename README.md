# From Zero to CI in 30 minutes

This repo is a clone of another DX project: https://github.com/Szandor72/logger used only to illustrate build capabilities with CircleCI 2.0. 

## Dev, Build and Test - all in one push
We will be using circle ci 2.0 for the purposes of this demo. All the amazing stuff you can do with DX is somewhat `screencast scripted` in `commands.txt` - you can follow along easily. There's also some best practices shared in there.

In order to get Continuous Integration up and running, create a connected app, a server.crt and server.key following these steps: https://trailhead.salesforce.com/modules/sfdx_travis_ci/units/sfdx_travis_ci_connected_app

Important: Do not use 'all user may self authorize'. Use Profiles or Permission Sets. 

## Circle CI 

Head over to https://circleci.com and sign up with your github account and add your new project/repo.

We will need to set up a few environment variables in Circle CI in order to securly store our credentials.

- First create a hex version of your server key (bash)
```
$ xxd -p server.key >> server.key.hex'
```

Now add the following environment vars at
 https://circleci.com/gh/$GithubUsername$/$RepositoryName$/edit#env-vars 

- DX_USERNAME: your dev-hub username
- DX_CONSUMER_KEY: the connected app's consumer key
- SSL_SERVER_KEY_HEX: the content of `server.key.hex`

CircleCI 2.0 is pretty straigtht forward to read without any prior experience. That's a huge improvement in comparison to 1.0. Have a look at `.circleci/config.yml`and for a general idea how to work with branch-level workflows: https://github.com/CircleCI-Public/circleci-demo-workflows/blob/sequential-branch-filter/.circleci/config.yml

Also, here are the slides from Barcelona: https://docs.google.com/presentation/d/16Bips8nfEFayiEhfbzSkEPNAsUb_cWKdcSB-K1qACzU/edit?usp=sharing

A connected app is not the only way to get things up and running. If many sandboxes are involved, have a look at _-commands.txt_ and _.circleci/config.yml_ to learn about another way to authenticate against an existing org.

There is a __feature__ and a __master__ flow in _./circleci/config.ym
## Feature Flow

The feature flow will take your code from any feature branch (feature/myFeature0 and push it two __two scratch orgs__. It will then run __all your tests distributedly__. In effect this cuts the test-time in half. 

## Master Flow

Will do a test-only deploy first, a real deployment after. Master flow need not stop here. If you are building a package, this is where you could also upload the package as beta and install this beta into yet another scratch org to run tests. 

It also illustrates how to manipulate metadata during build time. In this case, all _userPermissions_ will be stripped from the _Admin.profile_. In effect this transports all object, fls settings but also for example layout assignments which cannot be be preserved by permission sets.

## Resources
- https://trailhead.salesforce.com/en/trails/sfdx_get_started
- https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_auth_connected_app.htm
- there's a setting you can use to specify oAuth port on `oauthLocalPort`
- https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_auth_key_and_cert.ht-= m

## DX Plugins to check out
DX can be extended in various ways, here are my two current favourites

- https://www.npmjs.com/package/sfdx-l18n-plugin
A plugin for the Salesforce CLI built by Mikkel Flindt Heisterberg to allow you to update the localization values on the created users object. This allows you to set the user interface language, the locale of the user (date/time formats) and the timezone of the user from the command line.

- https://www.npmjs.com/package/sfdx-msm-plugin
lots of supercool utilities. E.g. Retrieving a package, unzipping, converting

- https://github.com/wadewegner/sfdx-code-gen
a dx plugin to create classes, components, any kind of metadata using pre-defined templates 
