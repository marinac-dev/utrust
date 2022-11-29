# Utrust

Decisions I made during the implementation.

## Reading the Challenge document

Hello, I've got my coffee so we can begin :).

...reading the task...

Okay, so from what I understood I just need to take Ethereum transaction hash and check it against Etherscan API and count block transaction confirmations. Sounds easy.

## First things, first

What is Ethereum transaction hash? 
- Every transaction that has been verified and added to the blockchain will receives hash, and it has a length of 32 bytes (usefull for validation).

How to use Etherscan API?
- I've made an account and got API key, so you will need one as well to run this app :)

What and how?
- For front-end I'm gonna use LiveView (sorry React gotta fit in 3 hours ETA). One live route leading to webpage, with input field and a button that will fetch data from API.
  Now description did mention that Utrust makes APIs, but task says web page - so instead of API, gonna make a web page :D (although BE API with React front-ent is sweet idea)
  First I should check for an up to date Etherscan API library... Okay, I am back and there is none matching that description. So Tesla adapter will do the job!

I'm forbidden to use any CSS frameworks :( ?
- Well examples mentioned opinionated frameworks like Bootstrap and Foundation and I assume that's for a good cause. They are component based and are pain to customize on huge projects.
  Lucky for me there is Tailwind CSS :D I'd assume that the person giving this challenge wants to test my CSS knowledge among other things and Tailwind is good at that. You can't use Tailwind if you don't know CSS really well because Tailwind is utility-first CSS framework. Meaning you have to have understanding of CSS for Tailwind to work out.

