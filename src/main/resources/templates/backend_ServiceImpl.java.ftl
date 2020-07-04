${gen.setType("serviceImpl")}
<#assign entityClass = "${entity.name}${settings.entitySuffix}" />
<#assign daoClass = "${entity.name}${settings.daoSuffix}" />
<#assign serviceClass = "${entity.name}${settings.serviceSuffix}" />
package ${settings.servicePackage}.impl;

import ${settings.entityPackage}.${entityClass};
import ${settings.daoPackage}.${daoClass};
import ${settings.servicePackage}.${serviceClass};

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

/**
* Service：${table.comment}
*
* @author ${developer.author}
* @date ${.now?string["yyyy-MM-dd HH:mm:ss"]}
*/
@CacheConfig(cacheNames = {${serviceClass}Impl.CACHE_NAME})
@Transactional(rollbackFor = Throwable.class)
@Service
public class ${serviceClass}Impl extends ServiceImpl<${daoClass}, ${entityClass}> implements ${serviceClass} {

    @Override
    public void save${entity.name}(${entityClass} entity) {
        if (!save(entity)) {
            throw new RuntimeException("保存信息失败");
        }
    }

    @Override
    public void update${entity.name}(${entityClass} entity) {
        // 使用 updateById(entity); 修改数据时，将会修改 entity 对象中所有非null数据，如果某个字段为null，将会忽略该字段的修改
        boolean update = updateById(entity);
        if (!update) {
            throw new RuntimeException("修改信息失败");
        }
    }

    @Override
    public void delete${entity.name}(String primaryKey) {
        removeById(primaryKey);
    }

    @Override
    public void delete${entity.name}(List<String> primaryKeys) {
        removeByIds(primaryKeys);
    }
}