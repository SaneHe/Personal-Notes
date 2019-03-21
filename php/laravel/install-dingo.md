### 1. 克隆项目仓库 修改项目下的 `composer.json` 文件，在后面新增

```
"minimum-stability" : "dev",
"prefer-stable" : true
```

### 2. 安装 `dingo`， `composer require dingo/api:^2.0.0-alpha2`；安装完成执行 `php artisan vendor:publish --provider="Dingo\Api\Provider\LaravelServiceProvider"` 发布配置文件，编辑项目下的 `.env` 文件

> 若出现此组件 `paragonie/random_compat ~9.99.99` 的报错, 执行命令 `composer require paragonie/random_compat:2.*`


### 3. 安装 `laravel/passport` 组件 `composer require laravel/passport ~4.0'

> 版本号是因为项目包 `laravel 5.5` 不支持高版本；

### 4. 生成所需要的基础表 `php artisan migrate`

### 5. 创建生成安全访问令牌（`token`）所需的加密键，此外，该命令还会创建 `“personal access”` 和 `“password grant”` 客户端用于生成访问令牌 `php artisan passport:install`

> `php artisan passport:keys` 生成Passport所需的加密密钥，以便生成访问令牌
> 
> `php artisan passport:client --password` 创建密码授予客户端

### 配置

- `config/auth.php`
```php
'guards' => [
        'api' => [
            'driver' => 'passport',
            'provider' => 'users',
        ],
    ],

 'providers' => [
        'users' => [
            'driver' => 'eloquent',
            'model' => \App\Models\User::class
        ],
    ],
```

- `Providers/AuthServiceProvider.php`
```php
use Laravel\Passport\Passport;
use Laravel\Passport\RouteRegistrar;

public function boot()
{
    $this->registerPolicies();

    //注册passport组件
    Passport::routes(function (RouteRegistrar $router) {
        //对于密码授权的方式只要这几个路由就可以了
        config(['auth.guards.api.provider' => 'users']);
        $router->forAccessTokens();
    }, ['prefix' => 'api/oauth']);

    Passport::tokensExpireIn(now()->addDays(30));
    Passport::refreshTokensExpireIn(now()->addDays(40));
    // 个人访问令牌
    Passport::personalAccessClient('2');
}
```

- `App/Http/Kernel.php`
``` php
protected $routeMiddleware = [
...     
'client_credentials' => \Laravel\Passport\Http\Middleware\CheckClientCredentials::class,
];

```