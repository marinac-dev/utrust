# Utrust

Decisions I made during the implementation. [Challenge document](https://docs.google.com/document/d/1hp5FqHAeDvwHBotbAZZaRTeG0aRtH-KY4n6rrFG61Gk/edit#)

## Reading the Challenge document

Hello, I've got my coffee so we can begin :).

...reading the task...

Okay, so from what I understood I just need to take Ethereum transaction hash and check it against Etherscan API and count block transaction confirmations. Sounds easy, right? Well no, Etherscan is not good enough for me :)

## First things, first

What is Ethereum transaction hash? 
- Every transaction that has been verified and added to the blockchain will receives hash, with length of 66 bytes (usefull for validation).

What and how?
- For front-end I'm gonna use LiveView (sorry React gotta fit in 3 hours ETA). One live route leading to webpage, with input field and a button that will fetch data from API.
  Now description did mention that Utrust makes APIs, but task says web page - so web page :D (although BE API with React front-ent is sweet idea).

Use of Etherscan API?
- Instead of Etherscan I chose myetherwallet (MEW) because Etherscan API doesn't provide much details from the looks of it.
- Image left is Etherscan and on the right is MyEtherWallet response

![Etherscan](/priv/static/images/etherscan_docs.png) ![MEW](/priv/static/images/mew.png)

I'm forbidden to use any CSS frameworks :( ?
- Well examples mentioned opinionated frameworks like Bootstrap and Foundation and I assume that's for a good cause. They are component based and are pain to customize on huge projects.
  Lucky for me there is Tailwind CSS :D I'd assume that the person giving this challenge wants to test my CSS knowledge among other things and Tailwind is good at that. You can't use Tailwind if you don't know CSS really well because Tailwind is utility-first CSS framework. Meaning you have to have understanding of CSS for Tailwind to work out.

Note: LiveView is gettint more and more powerfull as each day goes by. I would reconsider making new FE endpoints in it instead of React.

## Final thoughts - tests?
- It's been a fun challenge, learned a bit more about technical side of blockchain. Definately couldn't do this in 2-3 hours alone, had to take a break and read a bit more about Ethereum. Trying Etherscan as API endpoint threw me off the right path for a while but I found solution in some open-source project. I could have invested more time in writing unit tests, mocking Tesla requests, integration tests, UI testing etc... I did expose api endpoint for React client but opted out of it in the end. I tried to stay as close as possible to a 3 hours mark but it wasn't easy :')
- I  could definately see myself doing this as daily job, I find it really interesting and it's a challenge that can keep me going for a long time.