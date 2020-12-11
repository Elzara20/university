# Наивный нормальный байесовский классификатор
Байесовский классификатор —  классификация, основанная на принципе максимума апостериорной вероятности. 
>Апостериорной называют условную вероятность значения, принимаемого случайной переменной, которое назначается после принятия во внимание некоторой новой, связанной с ней информации, и вычисляется с помощью теоремы Байеса. Иными словами, это вероятность события A при условии, что произошло событие B. **(ее можно определить только после того, как мы узнаем признаки объекта)**
##### Теорема (об оптимальности байесовского классификатора):
Если известны априорные вероятности ![](https://latex.codecogs.com/gif.latex?P_y) и функции правдоподобия ![](https://latex.codecogs.com/gif.latex?p_y(x)), поставим в соответствие величину потери ![](https://latex.codecogs.com/gif.latex?\lambda_{ys}) при отнесении объекта класса ![](https://latex.codecogs.com/gif.latex?y) к классу ![](https://latex.codecogs.com/gif.latex?s), a ![](https://latex.codecogs.com/gif.latex?\lambda_{yy}=0) , то минимум среднего риска ![](https://latex.codecogs.com/gif.latex?R(a)) достигается алгоритмом:


![](https://latex.codecogs.com/gif.latex?a(x)=\arg&space;\max_{y\in&space;Y}\lambda_yP_yp_y(x).)


Оптимальный алгоритм классификации  можно переписать через апостериорные вероятности, поэтому данное выражение называют оптимальным байесовским правилом.

## Наивный байесовский классификатор
Наивный байесовский классификатор снован на формуле, что объекты описываются независимыми признаками (из-за этого название наивный). Предположение о независимости существенно упрощает задачу, так как оценить ![](https://latex.codecogs.com/gif.latex?n) одномерных плотностей гораздо легче, чем одну ![](https://latex.codecogs.com/gif.latex?n)-мерную плотность.

Будем полагать, что все объекты описываются n числовыми признаками. Обозначим через ![](https://latex.codecogs.com/gif.latex?x=(\xi_1,\dots,\xi_n)), где ![](https://latex.codecogs.com/gif.latex?\xi_j=f_j(x)). Если все признаки независимы, то все функции правдоподобия представлены в виде произведения:


![](https://latex.codecogs.com/gif.latex?p_y(x)=p_{y1}(\xi_1),\dots,p_{yn}(\xi_n))

Подставим эмпирические оценки одномерных плотностей в оптимальный байесовский классификатор:

>На практике при умножении очень малых условных вероятностей может наблюдаться потеря значащих разрядов, в связи с чем вместо самих оценок апостериорных вероятностей применяют логарифмы этих вероятностей. Поскольку логарифм - монотонно возрастающая функция, то класс   с наибольшим значением логарифма вероятности останется наиболее вероятным. 


![](https://latex.codecogs.com/gif.latex?a%28x%29%3D%5Carg%20%5Cmax_%7By%5Cin%20Y%7D%28%5Cln%28%5Clambda_yP_y%29&plus;%5Csum_%7Bj%3D1%7D%5En%20%5Cln%28p_%7Byj%7D%28%5Cxi_j%29%29%29.)

## Алгоритм
Используется нормальный байесовский классификатор. Функция правдоподобия расчитывается по формуле:
![](https://latex.codecogs.com/gif.latex?p%28x%29%3D%5Cfrac%7B1%7D%7B%5Csqrt%282%5Cpi%20D%29%7D%20e%5E%7B-%5Cfrac%7B%28x-E%29%5E2%7D%7B2D%7D%7D)
где ![](https://latex.codecogs.com/gif.latex?D) - дисперсия, ![](https://latex.codecogs.com/gif.latex?E) - математическое ожидание
```R
for (j in 1:3){
      ans[j]<-1/sqrt(2*pi*D_new[j])*(exp(-(data_new-E_new[j])^2/(2*D_new[j])))
  }
```
Дисперсия просчитывается по формуле:
![](https://latex.codecogs.com/gif.latex?D%28X%29%3D%5Csum_%7Bi%3D1%7D%5En%20x_i%5E2p_i-%28%5Csum_%7Bi%3D1%7D%5En%20x_ip_i%29%5E2)

```R
 for (i in 1:N){
    a1[i]<-(A[i,2])^2*p
    a2[i]<-(A[i,2]*p)
  }
  ans[2]<-sum(a1)-(sum(a2))^2
```
где ![](https://latex.codecogs.com/gif.latex?p_i) - вероятность появления объекта.
Математическое ожидание просчитываю как среднее арифметическое ( все события равновероятны)
```R
for (i in 1:n){
    ans[i]<-mean(A[,i]) #равномерное распределение
  }
```

За обучающую выборку были взяты Ирисы Фишера. Так как предположили, что все классы равнозначны (основа наивного байесовского классификатора), то величина потери ![](https://latex.codecogs.com/gif.latex?\lambda=1) для всех классов 
Результат работы
![]()














# Dillinger

[![N|Solid](https://cldup.com/dTxpPi9lDf.thumb.png)](https://nodesource.com/products/nsolid)

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

Dillinger is a cloud-enabled, mobile-ready, offline-storage, AngularJS powered HTML5 Markdown editor.

  - Type some Markdown on the left
  - See HTML in the right
  - Magic

# New Features!

  - Import a HTML file and watch it magically convert to Markdown
  - Drag and drop images (requires your Dropbox account be linked)


You can also:
  - Import and save files from GitHub, Dropbox, Google Drive and One Drive
  - Drag and drop markdown and HTML files into Dillinger
  - Export documents as Markdown, HTML and PDF

Markdown is a lightweight markup language based on the formatting conventions that people naturally use in email.  As [John Gruber] writes on the [Markdown site][df1]

> The overriding design goal for Markdown's
> formatting syntax is to make it as readable
> as possible. The idea is that a
> Markdown-formatted document should be
> publishable as-is, as plain text, without
> looking like it's been marked up with tags
> or formatting instructions.

This text you see here is *actually* written in Markdown! To get a feel for Markdown's syntax, type some text into the left window and watch the results in the right.

### Tech

Dillinger uses a number of open source projects to work properly:

* [AngularJS] - HTML enhanced for web apps!
* [Ace Editor] - awesome web-based text editor
* [markdown-it] - Markdown parser done right. Fast and easy to extend.
* [Twitter Bootstrap] - great UI boilerplate for modern web apps
* [node.js] - evented I/O for the backend
* [Express] - fast node.js network app framework [@tjholowaychuk]
* [Gulp] - the streaming build system
* [Breakdance](https://breakdance.github.io/breakdance/) - HTML to Markdown converter
* [jQuery] - duh

And of course Dillinger itself is open source with a [public repository][dill]
 on GitHub.

### Installation

Dillinger requires [Node.js](https://nodejs.org/) v4+ to run.

Install the dependencies and devDependencies and start the server.

```sh
$ cd dillinger
$ npm install -d
$ node app
```

For production environments...

```sh
$ npm install --production
$ NODE_ENV=production node app
```

### Plugins

Dillinger is currently extended with the following plugins. Instructions on how to use them in your own application are linked below.

| Plugin | README |
| ------ | ------ |
| Dropbox | [plugins/dropbox/README.md][PlDb] |
| GitHub | [plugins/github/README.md][PlGh] |
| Google Drive | [plugins/googledrive/README.md][PlGd] |
| OneDrive | [plugins/onedrive/README.md][PlOd] |
| Medium | [plugins/medium/README.md][PlMe] |
| Google Analytics | [plugins/googleanalytics/README.md][PlGa] |


### Development

Want to contribute? Great!

Dillinger uses Gulp + Webpack for fast developing.
Make a change in your file and instantaneously see your updates!

Open your favorite Terminal and run these commands.

First Tab:
```sh
$ node app
```

Second Tab:
```sh
$ gulp watch
```

(optional) Third:
```sh
$ karma test
```
#### Building for source
For production release:
```sh
$ gulp build --prod
```
Generating pre-built zip archives for distribution:
```sh
$ gulp build dist --prod
```
### Docker
Dillinger is very easy to install and deploy in a Docker container.

By default, the Docker will expose port 8080, so change this within the Dockerfile if necessary. When ready, simply use the Dockerfile to build the image.

```sh
cd dillinger
docker build -t joemccann/dillinger:${package.json.version} .
```
This will create the dillinger image and pull in the necessary dependencies. Be sure to swap out `${package.json.version}` with the actual version of Dillinger.

Once done, run the Docker image and map the port to whatever you wish on your host. In this example, we simply map port 8000 of the host to port 8080 of the Docker (or whatever port was exposed in the Dockerfile):

```sh
docker run -d -p 8000:8080 --restart="always" <youruser>/dillinger:${package.json.version}
```

Verify the deployment by navigating to your server address in your preferred browser.

```sh
127.0.0.1:8000
```

#### Kubernetes + Google Cloud

See [KUBERNETES.md](https://github.com/joemccann/dillinger/blob/master/KUBERNETES.md)


### Todos

 - Write MORE Tests
 - Add Night Mode

License
----

MIT


**Free Software, Hell Yeah!**

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)


   [dill]: <https://github.com/joemccann/dillinger>
   [git-repo-url]: <https://github.com/joemccann/dillinger.git>
   [john gruber]: <http://daringfireball.net>
   [df1]: <http://daringfireball.net/projects/markdown/>
   [markdown-it]: <https://github.com/markdown-it/markdown-it>
   [Ace Editor]: <http://ace.ajax.org>
   [node.js]: <http://nodejs.org>
   [Twitter Bootstrap]: <http://twitter.github.com/bootstrap/>
   [jQuery]: <http://jquery.com>
   [@tjholowaychuk]: <http://twitter.com/tjholowaychuk>
   [express]: <http://expressjs.com>
   [AngularJS]: <http://angularjs.org>
   [Gulp]: <http://gulpjs.com>

   [PlDb]: <https://github.com/joemccann/dillinger/tree/master/plugins/dropbox/README.md>
   [PlGh]: <https://github.com/joemccann/dillinger/tree/master/plugins/github/README.md>
   [PlGd]: <https://github.com/joemccann/dillinger/tree/master/plugins/googledrive/README.md>
   [PlOd]: <https://github.com/joemccann/dillinger/tree/master/plugins/onedrive/README.md>
   [PlMe]: <https://github.com/joemccann/dillinger/tree/master/plugins/medium/README.md>
   [PlGa]: <https://github.com/RahulHP/dillinger/blob/master/plugins/googleanalytics/README.md>
